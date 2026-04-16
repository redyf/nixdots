{
  lib,
  config,
  pkgs,
  ...
}:
let
  gitSyncObsidian = pkgs.writeShellScriptBin "git-sync-obsidian" ''
    #!/usr/bin/env sh
    VAULT_DIR="$HOME/Documents/GitHub_Vault"
    LOCKFILE="/tmp/git-sync-obsidian.lock"

    # Prevent concurrent runs
    if [ -e "$LOCKFILE" ]; then
      echo "Sync already running, skipping." >&2
      exit 0
    fi
    trap 'rm -f "$LOCKFILE"' EXIT
    touch "$LOCKFILE"

    cd "$VAULT_DIR" || exit 1

    # Pull remote changes first, then commit local ones on top
    git pull --rebase origin main || exit 1
    git lfs pull

    git add .
    git diff --cached --quiet || git commit -m "sync: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
  '';

  setupObsidianLFS = pkgs.writeShellScriptBin "setup-obsidian-lfs" ''
    #!/usr/bin/env sh
    VAULT_DIR="$HOME/Documents/GitHub_Vault"
    cd $VAULT_DIR || exit 1

    git lfs track "*.png" "*.jpg" "*.jpeg" "*.gif" "*.webp" "*.bmp"
    git add .gitattributes
    git commit -m "Configure Git LFS for images"
    git lfs migrate import --include="*.png,*.jpg,*.jpeg,*.gif,*.webp,*.bmp"
    git push --force-with-lease origin main
  '';
in
{
  options = {
    obsidian.enable = lib.mkEnableOption "Enable obsidian module";
  };
  config = lib.mkIf config.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
      gitSyncObsidian
      setupObsidianLFS
    ];
    systemd.user = {
      services.git-sync-obsidian = {
        Unit = {
          Description = "Sync Obsidian Vault with GitHub";
          Wants = [ "git-sync-obsidian.timer" "network-online.target" ];
          After = [ "network-online.target" ];
        };
        Service = {
          ExecStart = "${gitSyncObsidian}/bin/git-sync-obsidian";
          Type = "simple";
        };
      };
      timers.git-sync-obsidian = {
        Unit.Description = "Run Git Sync for Obsidian Vault";
        Timer = {
          OnCalendar = "*:0/45";
          Persistent = true;
        };
        Install.WantedBy = [ "timers.target" ];
      };
    };
  };
}
