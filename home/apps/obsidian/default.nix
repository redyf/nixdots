{
  lib,
  config,
  pkgs,
  ...
}:
let
  gitSyncObsidian = pkgs.writeShellScriptBin "git-sync-obsidian" ''
    #!/usr/bin/env sh

    VAULT_DIR="$HOME/Documentos/GitHub_Vault"

    cd $VAULT_DIR || exit 1

    git add .

    git commit -m "$(date '+%Y-%m-%d %H:%M:%S')" || exit 0

    git pull --rebase origin main || exit 1
    git push origin main
  '';

  obsidianOllama = pkgs.writeShellScriptBin "obsidianOllama" ''
    #!/usr/bin/env sh
    start_ollama_model() {
        echo "Iniciando o modelo do Ollama..."
        OLLAMA_ORIGINS=app://obsidian.md* ollama serve &
        OLLAMA_PID=$!  # Salva o PID do processo do Ollama
    }

    # Função para parar o modelo do Ollama
    stop_ollama_model() {
        if [[ -n "$OLLAMA_PID" ]] && kill -0 "$OLLAMA_PID" 2>/dev/null; then
            echo "Parando o modelo do Ollama..."
            kill "$OLLAMA_PID"
        fi
    }

    # Inicia o modelo do Ollama
    start_ollama_model

    # Inicia o Obsidian e aguarda ele fechar
    obsidian &
    OBSIDIAN_PID=$!
    wait "$OBSIDIAN_PID"

    # Para o modelo do Ollama após o fechamento do Obsidian
    stop_ollama_model
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
      # ollama
      # obsidianOllama
    ];
    systemd.user = {
      services.git-sync-obsidian = {
        Unit = {
          Description = "Sync Obsidian Vault with GitHub";
          Wants = "git-sync-obsidian.timer";
        };
        Service = {
          ExecStart = "${gitSyncObsidian}/bin/git-sync-obsidian";
          Type = "simple";
        };
      };
      timers.git-sync-obsidian = {
        Unit.Description = "Run Git Sync for Obsidian Vault";
        Timer.OnCalendar = "*:0/15";
        Install.WantedBy = [ "timers.target" ];
      };
    };
  };
}
