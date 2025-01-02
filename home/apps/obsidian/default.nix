{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    obsidian.enable = lib.mkEnableOption "Enable obsidian module";
  };
  config = lib.mkIf config.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
      # ollama
      # (writeShellScriptBin "obsidianOllama" ''
      #   #!/usr/bin/env sh
      #   start_ollama_model() {
      #       echo "Iniciando o modelo do Ollama..."
      #       OLLAMA_ORIGINS=app://obsidian.md* ollama serve &
      #       OLLAMA_PID=$!  # Salva o PID do processo do Ollama
      #   }
      #
      #   # Função para parar o modelo do Ollama
      #   stop_ollama_model() {
      #       if [[ -n "$OLLAMA_PID" ]] && kill -0 "$OLLAMA_PID" 2>/dev/null; then
      #           echo "Parando o modelo do Ollama..."
      #           kill "$OLLAMA_PID"
      #       fi
      #   }
      #
      #   # Inicia o modelo do Ollama
      #   start_ollama_model
      #
      #   # Inicia o Obsidian e aguarda ele fechar
      #   obsidian &
      #   OBSIDIAN_PID=$!
      #   wait "$OBSIDIAN_PID"
      #
      #   # Para o modelo do Ollama após o fechamento do Obsidian
      #   stop_ollama_model
      # '')
    ];
  };
}
