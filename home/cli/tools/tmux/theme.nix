let
  colors = {
    bg = "#1e1e2e";
    bg_selected = "#313244";
    fg = "#cdd6f4";
    fg_muted = "#a6adc8";
    fg_dim = "#6c7086";
    border = "#45475a";
    accent = "#89b4fa";
  };
in
''
  # No bells
  set -g visual-activity off
  set -g visual-bell off
  set -g visual-silence off
  setw -g monitor-activity off
  set -g bell-action none

  # Status bar
  set -g status-position top
  set -g status-justify left
  set -g status-style "bg=${colors.bg} fg=${colors.fg_muted}"
  set -g status-interval 1

  # Left: session
  set -g status-left "#[fg=${colors.accent},bold] #S #[fg=${colors.fg_dim}]│ "
  set -g status-left-length 20

  # Right: git branch and time
  set -g status-right "#[fg=${colors.accent}]#(git -C #{q:pane_current_path} branch --show-current 2>/dev/null) #[fg=${colors.fg_muted}]%-I:%M %p "
  set -g status-right-length 50

  # Window format
  setw -g window-status-format "#[fg=${colors.fg_dim}] #I #W "
  setw -g window-status-current-format "#[fg=${colors.fg},bold] #I #W "
  setw -g window-status-separator ""

  # Pane borders
  set -g pane-border-lines simple
  set -g pane-border-style "fg=${colors.border}"
  set -g pane-active-border-style "fg=${colors.accent}"

  # Message style
  set -g message-style "bg=${colors.bg_selected} fg=${colors.fg}"
  set -g message-command-style "bg=${colors.bg_selected} fg=${colors.fg}"

  # Mode style (copy mode)
  setw -g mode-style "bg=${colors.bg_selected} fg=${colors.fg}"

  # Clock
  setw -g clock-mode-colour "${colors.accent}"
''
