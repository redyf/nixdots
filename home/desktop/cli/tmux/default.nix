{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    terminal = "xterm-256color";
    escapeTime = 500;
    keyMode = "vi";
    prefix = "C-Space";
    mouse = true;
    extraConfig = ''
      # Set true color
      # set-option -sa terminal-overrides ",xterm*:Tc"

      # Set prefix
      # unbind C-b
      # set -g prefix C-Space
      # bind C-Space send-prefix

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Start windows and panes at 1, not 0
      # set -g base-index 1
      # set -g pane-base-index 1
      # set-window-option -g pane-base-index 1
      # set-option -g renumber-windows on

      # Enable catppuccin theme
      # set -g @catppuccin_flavour 'mocha'

      # Enable mouse support
      # set -g mouse on

      # Set vi-mode
      set-window-option -g mode-keys vi

      # keybindings
      # bind-key -T copy-mode-vi v send-keys -X begin-selection
      # bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      # bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Open panes in current directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # ----- Messages -----
      set-option -g mode-style 'bg=blue, fg=black'
      set-option -g message-style 'bg=blue, fg=black'

      # ----- Center -----
      set-option -g status-justify centre
      set-option -g status-style "bg=black"
      set-window-option -g window-status-current-format '#[bold]#[fg=blue, bg=black]#[fg=black, bg=blue]#I:#W#[fg=blue, bg=black]'
      set-window-option -g window-status-format '#I:#W'
      set-window-option -g window-status-separator ' '
      set-window-option -g window-status-style "bg=black"
      set-window-option -g window-status-current-style "bg=blue,fg=black"


      # ----- Left -----
      set-option -g status-left " #S #[fg=blue, bg=black]"
      set-option -g status-left-style "bg=blue,fg=black"


      # ----- Right -----
      set-option -g status-right "#[fg=blue, bg=black] #[fg=black, bg=blue] %d/%m  %R "
      set-option -g status-right-style "bg=black,fg=blue"
    '';
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      # tmuxPlugins.catppuccin
      tmuxPlugins.yank
    ];
  };
}
