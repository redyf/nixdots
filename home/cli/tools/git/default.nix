{
  pkgs,
  lib,
  config,
  homeDirectory,
  ...
}:
let
  cfg = config.git;
in
{
  options = {
    git = {
      enable = lib.mkEnableOption "Enable git module";
      sopsIdentity.enable = lib.mkEnableOption "SOPS-rendered Git identity includes";
      work.enable = lib.mkEnableOption "work Git/SSH settings";
      workDirectory = lib.mkOption {
        type = lib.types.str;
        default = "${homeDirectory}/work";
        description = "Directory that uses the work Git identity.";
      };
      maintenanceRepo = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Repository path for Git maintenance.";
      };
      safeDirectories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Git safe.directory entries.";
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs = {
        enable = true;
      };
      includes =
        lib.optionals cfg.sopsIdentity.enable [
          { path = "/run/secrets/rendered/git-personal"; }
        ]
        ++ lib.optionals (cfg.sopsIdentity.enable && cfg.work.enable) [
          {
            path = "/run/secrets/rendered/git-work";
            condition = "gitdir:${cfg.workDirectory}/*/";
          }
        ];
      settings = {
        core = {
          editor = "nvim";
        };
        init = {
          defaultBranch = "main";
        };
        branch = {
          autoSetupRemote = true;
        };
        fetch = {
          prune = true;
        };
        pull = {
          ff = false;
          commit = false;
          rebase = true;
          prune = true;
        };
      }
      // lib.optionalAttrs (cfg.maintenanceRepo != null) {
        maintenance.repo = cfg.maintenanceRepo;
      }
      // lib.optionalAttrs (cfg.safeDirectories != [ ]) {
        safe.directory = cfg.safeDirectories;
      };
    };
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/id_ed25519";
        };
      }
      // lib.optionalAttrs cfg.work.enable {
        "github-work" = {
          hostname = "github.com";
          user = "git";
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/id_ed25519_work";
        };

        "github-ezops" = {
          hostname = "github.com";
          user = "git";
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/id_ed25519_work";
        };
      };
    };
    home = {
      packages = [
        pkgs.gh
      ];
    };
  };
}
