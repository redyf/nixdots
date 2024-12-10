{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    misc.enable = lib.mkEnableOption "Enable misc module";
  };
  config = lib.mkIf config.misc.enable {
    home.packages = with pkgs; [
      # Anime/Manga
      # ani-cli # A cli tool to browse and play anime
      # mangal # A fancy CLI app written in Go which scrapes, downloads and packs manga into different formats

      # Gaming
      prismlauncher

      # Other stuff
      playerctl
      pavucontrol
      libreoffice
      realvnc-vnc-viewer
      postman
      (writeShellScriptBin "obsidianOllama" ''
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
      '')
      obsidian
      tldr
      ollama

      # Extra utils
      wget
      parted
      mpv
      unzip # Unzip files using the terminal
      ffmpeg_6 # A complete, cross-platform solution to record, convert and stream audio and video
      polkit_gnome
      yazi
    ];
  };
}
