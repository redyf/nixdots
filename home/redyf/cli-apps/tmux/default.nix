{pkgs, ...}: let
  catppuccin-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "0.0.1.dmmulroy-fork";
    src = pkgs.fetchFromGitHub {
      owner = "dmmulroy";
      repo = "catppuccin-tmux";
      rev = "ec8df6268a6e5271c693ea34fc545000cec1fced";
      sha256 = "1hjav791xr5jx0swx4njfxlhhhx599ddan3bgaw1abwwfy1w1ji3";
    };
  };
in {
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
      # net-speed
      # {
      #   plugin = tokyo-night;
      #   extraConfig = builtins.readFile ./tokyo-night-tmux.conf;
      # }
      # {
      #   plugin = power-theme;
      #   extraConfig = builtins.readFile ./power-theme.conf;
      # }
      # {
      #   plugin = catppuccin;
      #   extraConfig = builtins.readFile ./catppuccin.conf;
      # }
      # {
      #   plugin = catppuccin-tmux;
      #   extraConfig = builtins.readFile ./catppuccin-custom.conf;
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
}
