{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    tmux-sessionizer
    # Script to find files with tmux in vim
    (writeShellScriptBin "tmux-sessionizer-script" ''
          if [[ $# -eq 1 ]]; then
          selected=$1
      else
          selected=$(find ~/projects ~/tests -mindepth 1 -maxdepth 1 -type d | fzf)
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
      # catppuccin
      yank
      sensible
      tmux-fzf
      vim-tmux-navigator
      inputs.tmux-sessionx.packages.${pkgs.system}.default
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

      # Sessionx plugin
      set -g @sessionx-bind '<prefix>+O'
      set -g @sessionx-x-path '~/nixdots'
      set -g @sessionx-filter-current 'false'
      set -g @sessionx-preview-enabled 'true'
      set -g @sessionx-window-height '95%'
      set -g @sessionx-window-width '75%'
      set -g @sessionx-zoxide-mode 'on'

      # Tmux sessionizer
      # forget the find window.  That is for chumps
      bind-key -r f run-shell "tmux neww tmux-sessionizer-script"

      #--------------------------------------------------------------------------
      # Status line
      #--------------------------------------------------------------------------
      # Enable catppuccin theme
      # set -g @catppuccin_flavour 'mocha'
      # Enable transparent tmux bar
      # set -g status-bg default
      # set -g status-style bg=default

      # Status line customisation
      set-option -g status-left-length 100
      set-option -g status-right-length 100
      set-option -g status-left " #{session_name}  "
      set-option -g status-right " "

      set-option -g status-style "fg=#828bb1 bg=default" # default will set the background to transparent

      set-option -g window-status-format "#{window_index}:#{window_name}#{window_flags} " # window_name -> pane_current_command
      set-option -g window-status-current-format "#{window_index}:#{window_name}#{window_flags} "
      set-option -g window-status-current-style "fg=#B4BEFE"
      set-option -g window-status-activity-style none

      # clock mode
      # setw -g clock-mode-colour colour1

      # copy mode
      # setw -g mode-style "fg=colour1 bg=colour18 bold"

      # pane borders
      set -g pane-border-style "fg=colour1"
      set -g pane-active-border-style "fg=colour3"

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

      # Biscuit
      # set-option -g status-left-length 0
      # set-option -g status-right-length 0
      # set -g status-position bottom
      # set -g status-justify centre
      # set -g status-left "#[bg=#171717, fg=#8e8aa9]   #[bg=#171717, fg=#a38c8c]#{session_name} #[fg=#151515]█#[fg=#131313]█#[fg=#111111]█"
      # set -g window-status-format "#[bg=#171717, fg=#736363] #I:#W "
      # set -g window-status-current-format "#[bg=#171717, fg=#8e8aa9] #I·#W "
      # set -g status-right "#[fg=#111111]█#[fg=#131313]█#[fg=#151515]█#[bg=#171717, fg=#a38c8c] %H:%M #[bg=#171717, fg=#8e8aa9]  "
      # set -g window-status-activity-style none

      # Tokyonight
      # # ----- Messages -----
      # set-option -g mode-style 'bg=blue, fg=black'
      # set-option -g message-style 'bg=blue, fg=black'
      #
      # # ----- Center -----
      # set-option -g status-justify centre
      # set-option -g status-style "bg=black"
      # set-window-option -g window-status-current-format '#[bold]#[fg=blue, bg=black]#[fg=black, bg=blue]#I:#W#[fg=blue, bg=black]'
      # set-window-option -g window-status-format '#I:#W'
      # set-window-option -g window-status-separator ' '
      # set-window-option -g window-status-style "bg=black"
      # set-window-option -g window-status-current-style "bg=blue,fg=black"


      # # ----- Left -----
      # set-option -g status-left " #S #[fg=blue, bg=black]"
      # set-option -g status-left-style "bg=blue,fg=black"
      #
      #
      # # ----- Right -----
      # set-option -g status-right "#[fg=blue, bg=black] #[fg=black, bg=blue] %d/%m  %R "
      # set-option -g status-right-style "bg=black,fg=blue"


      # Nord
      #+--- tmux-prefix-highlight ---+
      # set -g @prefix_highlight_output_prefix "#[fg=brightcyan]#[bg=black]#[nobold]#[noitalics]#[nounderscore]#[bg=brightcyan]#[fg=black]"
      # set -g @prefix_highlight_output_suffix ""
      # set -g @prefix_highlight_copy_mode_attr "fg=brightcyan,bg=black,bold"

      #+--------+
      #+ Status +
      #+--------+
      #+--- Bars ---+
      # set -g status-left "#[fg=brightblack,bg=black]#[fg=white,bg=brightblack,bold] #S #[fg=brightblack,bg=black,nobold,noitalics,nounderscore]"
      # set -g status-right "#{prefix_highlight}#[fg=brightblack,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack,nobold] #H #[fg=brightblack,bg=black,nobold]"

      #+--- Windows ---+
      # set -g window-status-format "#[fg=brightblack,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] #I#[fg=white,bg=brightblack,nobold,noitalics,nounderscore]: #W #[fg=brightblack,bg=black,nobold,noitalics,nounderscore]"
      # set -g window-status-current-format "#[fg=#5e81ac,bg=black]#[fg=white,bg=#5e81ac,bold,noitalics,nounderscore] #I#[fg=white,bg=#5e81ac,bold,noitalics,nounderscore]: #W #[fg=#5e81ac,bg=black,nobold,noitalics,nounderscore]"
      # set -g window-status-separator " "

      # Center the window list (yes, this value has to be written as "centre").
      # set -g status-justify centre

      #+----------------+
      #+    Windows     +
      #+----------------+
      #+--- Bars ---+
      # set -g pane-active-border-style "bg=default fg=blue"
    '';
  };
}
