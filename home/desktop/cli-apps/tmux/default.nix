{pkgs, ...}: let
  catppuccin-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "0.0.1.dmmulroy-fork";
    src = pkgs.fetchFromGitHub {
      owner = "dmmulroy";
      repo = "catppuccin-tmux";
      rev = "ec8df6268a6e5271c693ea34fc545000cec1fced";
      sha256 = "sha256-I8rAg3ecLxW4emtY1VpKpUMIaXfSks416LLkHtLZSsI=";
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
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      # {
      #   plugin = catppuccin;
      #   extraConfig = builtins.readFile ./catppuccin.conf;
      # }
      # {
      #   plugin = catppuccin-tmux;
      #   extraConfig = builtins.readFile ./catppuccin-custom.conf;
      # }
      {
        plugin = rose-pine;
        extraConfig = builtins.readFile ./rose-pine.conf;
      }
      yank
      sensible
      tmux-fzf
      vim-tmux-navigator
    ];
    extraConfig = ''
      #--------------------------------------------------------------------------
      # Keybinds
      #--------------------------------------------------------------------------
      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

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

      # TokyoNight colors for Tmux
      # set -g mode-style "fg=#7aa2f7,bg=#3b4261"
      #
      # set -g message-style "fg=#7aa2f7,bg=#3b4261"
      # set -g message-command-style "fg=#7aa2f7,bg=#3b4261"
      #
      # set -g pane-border-style "fg=#3b4261"
      # set -g pane-active-border-style "fg=#7aa2f7"
      #
      # set -g status "on"
      # set -g status-justify "left"
      #
      # set -g status-style "fg=#7aa2f7,bg=#1e1e2e"
      #
      # set -g status-left-length "100"
      # set -g status-right-length "100"
      #
      # set -g status-left-style NONE
      # set -g status-right-style NONE
      #
      # set -g status-left "#[fg=#1d202f,bg=#1e1e2e,bold] #S #[fg=#7aa2f7,bg=#1e1e2e,nobold,nounderscore,noitalics]"
      # set -g status-right "#[fg=#1f2335,bg=#1e1e2e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#1e1e2e] #{prefix_highlight} #[fg=#3b4261,bg=#1e1e2e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1d202f,bg=#7aa2f7,bold] #h "
      # if-shell '[ "$(tmux show-option -gqv "clock-mode-style")" == "24" ]' {
      #   set -g status-right "#[fg=#1f2335,bg=#1e1e2e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#1e1e2e] #{prefix_highlight} #[fg=#3b4261,bg=#1e1e2e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %H:%M #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1d202f,bg=#7aa2f7,bold] #h "
      # }
      #
      # setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#1e1e2e"
      # setw -g window-status-separator ""
      # setw -g window-status-style "NONE,fg=#a9b1d6,bg=#1e1e2e"
      # setw -g window-status-format "#[fg=#1f2335,bg=#1e1e2e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1f2335,bg=#1e1e2e,nobold,nounderscore,noitalics]"
      # setw -g window-status-current-format "#[fg=#1f2335,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#1e1e2e,nobold,nounderscore,noitalics]"

      # tmux-plugins/tmux-prefix-highlight support
      # set -g @prefix_highlight_output_prefix "#[fg=#e0af68]#[bg=#1e1e2e]#[fg=#1f2335]#[bg=#e0af68]"
      # set -g @prefix_highlight_output_suffix ""

      # Enable transparent tmux bar
      set -g status-bg default
      set -g status-style bg=default

      # Status line customisation
      # set-option -g status-left-length 100
      # set-option -g status-right-length 100
      # set-option -g status-left " #{session_name}  "
      # set-option -g status-right " "
      #
      # set-option -g status-style "fg=#828bb1 bg=default" # default will set the background to transparent

      # set-option -g window-status-format "#{window_index}:#{window_name}#{window_flags} " # window_name -> pane_current_command
      # set-option -g window-status-current-format "#{window_index}:#{window_name}#{window_flags} "
      # set-option -g window-status-current-style "fg=#B4BEFE"
      # set-option -g window-status-activity-style none

      # clock mode
      # setw -g clock-mode-colour colour1

      # copy mode
      # setw -g mode-style "fg=colour1 bg=colour18 bold"

      # pane borders
      # set -g pane-border-style "fg=colour1"
      # set -g pane-active-border-style "fg=colour3"

      # statusbar
      # set -g status-justify left
      # set -g status-style "fg=colour1"
      # set -g status-left ""
      # set -g status-right "%Y-%m-%d %H:%M "
      # set -g status-right-length 50
      # set -g status-left-length 10
      #
      # setw -g window-status-current-style "fg=colour0 bg=colour1 bold"
      # setw -g window-status-current-format " #I #W #F "
      #
      # setw -g window-status-style "fg=colour1 dim"
      # setw -g window-status-format " #I #[fg=colour7]#W #[fg=colour1]#F "
      #
      # setw -g window-status-bell-style "fg=colour2 bg=colour1 bold"
      #
      # # messages
      # set -g message-style "fg=colour2 bg=colour0 bold"
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
          selected=$(find ~/ ~/projects ~/tests -mindepth 1 -maxdepth 1 -type d | fzf)
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
          tmux attach -t $selected_name
      else
          tmux switch-client -t $selected_name
      fi
    '')
  ];
}
