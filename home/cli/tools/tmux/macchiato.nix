{ config }:
let
  stylixColors = config.lib.stylix.colors;
  colors = {
    base = "#${stylixColors.base00}";
    background = "default";
    surface0 = "#${stylixColors.base01}";
    surface1 = "#${stylixColors.base02}";
    overlay0 = "#${stylixColors.base03}";
    text = "#${stylixColors.base05}";
    overlay1 = "#${stylixColors.base04}";
    yellow = "#${stylixColors.base0A}";
    green = "#${stylixColors.base0B}";
    blue = "#${stylixColors.base0D}";
    mauve = "#${stylixColors.base0E}";
    directoryIcon = "󰉋";
    gitIcon = "";
    directoryText = "#{b:pane_current_path}";
  };
in
''
  # Catppuccin Macchiato
  set -g status-position top
  set -g status-justify left
  set -g status-style "bg=${colors.background} fg=${colors.overlay0}"
  set -g status-interval 1

  # Window list: rectangular tabs with spacing between them
  set -g status-left ""
  set -g status-left-length 0
  setw -g window-status-separator " "
  setw -g window-status-style "fg=${colors.overlay0},bg=${colors.background}"
  setw -g window-status-format "#[fg=${colors.overlay0},bg=${colors.surface0}] #W "
  setw -g window-status-current-format "#[fg=${colors.base},bg=${colors.blue}] #W "

  # Right side: plain segments avoid repeating tab rectangles
  set -g status-right-length 200
  set -g status-right "\
  #[fg=${colors.overlay0},bg=${colors.background}] + \
  #[fg=${colors.overlay1},bg=${colors.background}] │ \
  #[fg=${colors.yellow},bg=${colors.background}] ${colors.directoryIcon} \
  #[fg=${colors.text},bg=${colors.background}] ${colors.directoryText} \
  #[fg=${colors.overlay1},bg=${colors.background}] │ \
  #[fg=${colors.green},bg=${colors.background}] ${colors.gitIcon} \
  #[fg=${colors.text},bg=${colors.background}] #(git -C #{pane_current_path} branch --show-current 2>/dev/null || printf ·) "

  # Pane, message, and copy-mode colors
  set -g pane-border-style "fg=${colors.surface1},bg=${colors.background}"
  set -g pane-active-border-style "fg=${colors.blue},bg=${colors.background}"
  set -g message-style "fg=${colors.text},bg=${colors.surface0}"
  set -g message-command-style "fg=${colors.text},bg=${colors.surface0}"
  setw -g mode-style "fg=${colors.base},bg=${colors.blue}"
''
