{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.cli-apps.tmux;
in
{
  options.cli-apps.tmux = with types; {
    enable = mkBoolOpt false "Enable or disable the tmux terminal.";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.tmux = {
      enable = true;
      clock24 = true;
      baseIndex = 1;
      terminal = "xterm-256color";
      escapeTime = 500;
      keyMode = "vi";
      prefix = "C-Space";
      mouse = true;
      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.catppuccin
        tmuxPlugins.yank
      ];
      extraConfig =
        ''
          # Shift Alt vim keys to switch windows
          # bind -n M-H previous-window
          # bind -n M-L next-window

          # Alt arrow keys to switch windows
          bind -T root M-Left previous-window
          bind -T root M-Right next-window

          # Open panes in current directory
          bind '"' split-window -v -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"

          # Enable catppuccin theme
          set -g @catppuccin_flavour 'mocha'
          # Enable transparent tmux bar
          set -g status-bg default
          set -g status-style bg=default

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
          #
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
  };
}
