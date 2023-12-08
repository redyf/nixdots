{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    extraConfig = ''
      # pane binds
      bind -n M-n select-pane -D
      bind -n M-e select-pane -U
      bind -n M-y select-pane -L
      bind -n M-o  select-pane -R
      bind -n M-Up resize-pane -U 5
      bind -n M-Down resize-pane -D 5
      bind -n M-Left resize-pane -L 5
      bind -n M-Right resize-pane -R 5

      # window binds
      bind -n C-M-y previous-window
      bind -n C-M-o next-window
      bind-key \" split-window -v -c "#{pane_current_path}"
      bind-key c split-window -h -c "#{pane_current_path}"
      bind-key v new-window -c "#{pane_current_path}"
      bind-key s choose-session
      bind-key ) swap-window -t +2
      bind-key ( swap-window -t -1

      unbind -T copy-mode MouseDragEnd1Pane
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
      bind P paste-buffer
      set -g history-file "~/.cache/tmux/.tmuxhistory"
      set -g repeat-time 700
      set -g mouse on
      set -g status on
      set -g focus-events on
      set -g automatic-rename on
      set -g renumber-windows on
      set -g monitor-activity on
      set -g visual-activity off
      set -g bell-action none
      set -g mode-keys vi
      set -g status-keys vi
      set -g base-index 1
      set -g pane-base-index 1
      set -g escape-time 0
      set -g history-limit 10000
      set -g pane-border-style "bg=default,fg=black"
      set -g pane-active-border-style "bg=default,fg=green"

      set-option -sa terminal-features ",alacritty:RGB"
      set -g default-terminal "screen-256color"

      set -g detach-on-destroy off

      set -g mode-style "bg=default,fg=default"
      set -g status-position bottom
      set -g status-interval 5
      set -g @emulate-scroll-for-no-mouse-alternate-buffer on

      set -g status-justify centre
      set -g status-left "#[fg=black,bg=green]   #[fg=green,bg=red]#{prefix_highlight}#[bg=default]"
      set -g window-status-format "#[fg=magenta,bg=black] #I:#W #[bg=default,fg=black]"
      set -g window-status-current-format "#[bg=magenta,fg=black] #I:#W #[bg=default,fg=black] #[bg=black,fg=red] #S #[bg=red,fg=black]   "
      set -g status-right "#[bg=black,fg=green] %I:%M %p #[fg=green,bg=black]█"

      set -g status-bg default
      set -g status-fg white
      set -g status-style "fg=white,bg=default"

    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.prefix-highlight;
        extraConfig = ''
          set -g @prefix_highlight_prefix_prompt "MOD"
          set -g @prefix_highlight_copy_prompt "COPY"
          set -g @prefix_highlight_sync_prompt " "
          set -g @prefix_highlight_bg "black"
          set -g @prefix_highlight_fg "red"
          set -g @prefix_highlight_empty_attr "fg=black,bg=red"
          set -g @prefix_highlight_copy_mode_attr "fg=blue,bg=black"
          set -g @prefix_highlight_sync_mode_attr "fg=black,bg=green"
          set -g @prefix_highlight_show_copy_mode on
          set -g @prefix_highlight_show_sync_mode on
          set -g @prefix_highlight_empty_has_affixes off
          set -g @prefix_highlight_output_prefix ""
          set -g @prefix_highlight_output_suffix ""
          set -g @prefix_highlight_empty_prompt ""
        '';
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
    ];
  };
}
