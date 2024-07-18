{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux module";
  };
  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      baseIndex = 1;
      terminal = "xterm-256color";
      escapeTime = 0;
      keyMode = "vi";
      prefix = "C-Space";
      shell = "${pkgs.zsh}/bin/zsh";
      mouse = true;
      plugins = with pkgs.tmuxPlugins; [
        yank
        sensible
        tmux-fzf
        vim-tmux-navigator
        # {
        #   plugin = catppuccin;
        #   extraConfig = builtins.readFile ./catppuccin.conf;
        # }
        # {
        #   plugin = rose-pine;
        #   extraConfig = builtins.readFile ./rose-pine.conf;
        # }
      ];
      extraConfig = ''
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
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # Don't exit from tmux when closing a session
        set -g detach-on-destroy off

        # Renumber all windows when any window is closed
        set -g renumber-windows on

        # Place status bar on top
        set -g status-position top

        # Tmux sessionizer
        bind-key -r f run-shell "tmux neww tmux-sessionizer-script"

        #--------------------------------------------------------------------------
        # Status line
        #--------------------------------------------------------------------------

        # Adding Git repo and branch to Tmux status line
        set -g status-right '#(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD)'
        set -g status-interval 1

        # Enable transparent tmux bar
        set -g status-bg default
        set -g status-style bg=default
      '';
    };
    home.packages = with pkgs; [
      # https://github.com/edr3x/tmux-sessionizer?tab=readme-ov-file#tmux-sessionizer
      tmux-sessionizer
      # Script to find files with tmux in vim
      (writeShellScriptBin "tmux-sessionizer-script" ''
        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            selected=$(find ~/projects ~/tests ~/ztm -mindepth 1 -maxdepth 1 -type d | fzf)
        fi

        if [[ -z $selected ]]; then
            exit 0
        fi

        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
            tmux new-session -s $selected_name -c $selected
            exit 0
        fi

        if ! tmux has-session -t=$selected_name 2> /dev/null; then
            tmux new-session -ds $selected_name -c $selected
        fi

        if [[ -z $TMUX ]]; then
            nvim "$selected"
            tmux kill-session -t $selected_name
        else
            nvim "$selected"
            tmux kill-session -t $selected_name
        fi
      '')
    ];
  };
}
