{ pkgs }:
''
  # status left look and feel
  set -g status-left-length 100
  set -g status-left ""
  set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=default,bold]   #S },#{#[bg=default,fg=#{@thm_red},bold]   #S }}"
  set -ga status-left "#[bg=default,fg=#{@thm_overlay0},none,bold]│"
  set -ga status-left "#[bg=default,fg=#{@thm_green},bold]   #{pane_current_command} "
  set -ga status-left "#[bg=default,fg=#{@thm_overlay0},none,bold]│"
  set -ga status-left "#[bg=default,fg=#{@thm_blue},bold]   #{=/-10/...:#{s|$USER|~|:#{b:pane_current_path}}} "
  set -ga status-left "#[bg=default,fg=#{@thm_overlay0},none,bold]#{?window_zoomed_flag,│,}"
  set -ga status-left "#[bg=default,fg=#{@thm_yellow},bold]#{?window_zoomed_flag,   zoom ,}"

  # status right look and feel
  set -g status-right-length 100
  set -g status-right ""
  set -ga status-right "#[bg=default,fg=#{@thm_blue},bold]  #($TMUX_PLUGIN_MANAGER_PATH/tmux-mem-cpu-load/tmux-mem-cpu-load -i 2 -m 2 | awk \'{print substr($1, 1, 2)}\')%% "
  set -ga status-right "#[bg=default,fg=#{@thm_overlay0},none,bold]│"
  set -ga status-right "#[bg=default,fg=#{@thm_green},bold] 󰍛 #{cpu_percentage} "
  set -ga status-right "#[bg=default,fg=#{@thm_overlay0},none,bold]│"
  set -ga status-right "#[bg=default,fg=#{@thm_red},bold] 󱐋#{?#{e|>=:20,#{battery_percentage}},#{#[bg=#{@thm_red},fg=default,bold]},#{#[bg=default,fg=#{@thm_red},bold]}} #{battery_percentage} "
  # set -ga status-right "#[bg=default,fg=#{@thm_red},bold] 󱐋#{?#{e|>=:20,#{battery_percentage}},#{#[bg=#{@thm_red},fg=default,bold]},#{#[bg=default,fg=#{@thm_green},bold]}} #{battery_percentage} "
  # set -ga status-right "#[bg=default,fg=#{@thm_overlay0},none,bold]│"
  # set -ga status-right "#[bg=default,fg=#{@thm_red},bold] 󰭦 %m-%d 󰅐 %H:%M "

  # Configure Tmux
  set -g status-position top
  set -g status-style "bg=default"
  set -g status-justify "absolute-centre"

  # pane border look and feel
  setw -g pane-border-status off
  # setw -g pane-border-status top
  setw -g pane-border-format ""
  setw -g pane-border-style "bg=default,fg=#{@thm_overlay0}"
  setw -g pane-active-border-style "bg=default,fg=#{@thm_red}"
  setw -g pane-border-lines single

  # window content (number)
  # set -wg automatic-rename on
  # set -g automatic-rename-format "window"
  # set -g window-status-current-format " #I#{?#{!=:#{window_name},window},: #W,} "
  # set -g window-status-format " #I#{?#{!=:#{window_name},window},: #W,} "

  # set -g window-status-style "bg=default,fg=#{@thm_rosewater}"
  # set -g window-status-last-style "bg=default,fg=#{@thm_peach}"
  # set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_base}"
  # set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_base},bold"
  # set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_base},bold"
  # set -gF window-status-separator "#[bg=default,fg=#{@thm_overlay0}]│"

  # window content (icon)
  set -g automatic-rename off
  set -g allow-rename off
  set -g window-status-format '\
  #{?#{==:#{pane_current_command},zsh},  ,\
  #{?#{==:#{pane_current_command},fish}, 󰈺 ,\
  #{?#{==:#{pane_current_command},nvim},  ,\
  #{?#{==:#{pane_current_command},git}, 󰊢 ,\
  #{?#{==:#{pane_current_command},htop}, ,\
  #{?#{==:#{pane_current_command},yazi}, 󰀶 ,\
  #{?#{==:#{pane_current_command},python}, 󰌠 ,\
  #{?#{==:#{pane_current_command},bash},  ,\
  #{?#{==:#{pane_current_command},ssh},  ,\
  #{?#{==:#{pane_current_command},node},  ,\
  #{?#{==:#{pane_current_command},cargo},  ,\
  #{?#{==:#{pane_current_command},rustc},  ,\
  #{?#{==:#{pane_current_command},lua},  ,\
   󰘧 }}}}}}}}}}}}}'
  set -g window-status-current-format '\
  #{?#{==:#{pane_current_command},zsh},  ,\
  #{?#{==:#{pane_current_command},fish}, 󰈺 ,\
  #{?#{==:#{pane_current_command},nvim},  ,\
  #{?#{==:#{pane_current_command},git}, 󰊢 ,\
  #{?#{==:#{pane_current_command},htop}, ,\
  #{?#{==:#{pane_current_command},yazi}, 󰀶 ,\
  #{?#{==:#{pane_current_command},python}, 󰌠 ,\
  #{?#{==:#{pane_current_command},nix}, 󱄅 ,\
  #{?#{==:#{pane_current_command},bash},  ,\
  #{?#{==:#{pane_current_command},ssh},  ,\
  #{?#{==:#{pane_current_command},node},  ,\
  #{?#{==:#{pane_current_command},cargo},  ,\
  #{?#{==:#{pane_current_command},rustc},  ,\
  #{?#{==:#{pane_current_command},lua},  ,\
   󰘧 }}}}}}}}}}}}}'
  # window style
  set -g window-status-style "bg=default,fg=#{@thm_rosewater}"
  set -g window-status-last-style "bg=default,fg=#{@thm_flamingo}"
  set -g window-status-current-style "bg=default,fg=#{@thm_peach},bold"
  set -g window-status-activity-style "bg=default,fg=#{@thm_pink},bold"
  set -g window-status-bell-style "bg=default,fg=#{@thm_red},bold"
  # set -gF window-status-separator "#[bg=default,fg=#{@thm_overlay2}]│"
''
