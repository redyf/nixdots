{
  pkgs,
  lib,
  config,
  ...
}:
let
  theme = import ./theme.nix;
in
{
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux module";
  };
  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      baseIndex = 1;
      terminal = "tmux-256color";
      escapeTime = 0;
      keyMode = "vi";
      prefix = "C-Space";
      mouse = true;
      newSession = true;
      secureSocket = true;
      plugins =
        let
          tmuxPluginsList = with pkgs.tmuxPlugins; [
            yank
            sensible
            tmux-fzf
            vim-tmux-navigator
            {
              plugin = resurrect;
              extraConfig = "set -g @resurrect-strategy-nvim 'session'";
            }
          ];
        in
        tmuxPluginsList;
      extraConfig = ''
        set -ag terminal-overrides ",xterm-256color:RGB"

        #--------------------------------------------------------------------------
        # Keybinds
        #--------------------------------------------------------------------------
        # Shift Alt vim keys to switch windows
        bind -n M-J previous-window
        bind -n M-K next-window

        # Open panes in current directory
        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

        # Copy mode
        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # Tmux popups
        # bind -n C-p display-popup -w 90 -h 30 -E "zsh"

        unbind p

        bind p paste-buffer

        # Don't exit from tmux when closing a session
        set -g detach-on-destroy off

        # Renumber all windows when any window is closed
        set -g renumber-windows on

        # Tmux sessionizer
        bind -r f run-shell "tmux neww tmux-sessionizer-script"

        ${theme}
      '';
    };
    home.packages = with pkgs; [
      # https://frontendmasters.github.io/dev-prod-2/lessons/navigation/tmux
      tmux-sessionizer
      # Script to find files with tmux in vim
      (writeShellScriptBin "tmux-sessionizer-script" ''
        selected=$(find ~/work ~/ztm ~/personal ~/projects ~/opensource ~/alura/ -maxdepth 1 -mindepth 1 -type d | fzf)
        if [[ -z "$selected" ]]; then
            exit 0
        fi
        selected_name=$(basename "$selected" | tr ".,: " "____")

        switch_to() {
            if [[ -z "$TMUX" ]]; then
                tmux attach-session -t "$selected_name"
            else
                tmux switch-client -t "$selected_name"
            fi
        }

        if tmux has-session -t="$selected_name"; then
            switch_to
        else
            tmux new-session -ds "$selected_name" -c "$selected"
            switch_to
        fi
      '')
      (pkgs.writeShellScriptBin "tmux-init"
        # bash
        ''
          if [ -z "$TMUX" ]; then
            i=0
            while true; do
                session_name="base-$i"
                if tmux has-session -t "$session_name" 2>/dev/null; then
                    clients_count=$(tmux list-clients -t "$session_name" 2>/dev/null | wc -l)
                    if [ $clients_count -eq 0 ]; then
                        tmux attach-session -t "$session_name"
                        break
                    fi
                    ((i++))
                else
                    tmux new-session -d -s "$session_name"
                    tmux attach-session -d -t "$session_name"
                    break
                fi
            done
          fi
        ''
      )
    ];
  };
}
