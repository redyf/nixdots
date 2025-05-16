{
  pkgs,
  lib,
  config,
  ...
}:
{
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
      plugins =
        let
          tmuxPluginsList = with pkgs.tmuxPlugins; [
            yank
            sensible
            tmux-fzf
            vim-tmux-navigator
          ];
        in
        tmuxPluginsList;
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

        # Navigate panes like in neovim
        # bind -r h select-pane -L
        # bind -r j select-pane -D
        # bind -r k select-pane -U
        # bind -r l select-pane -R

        # Unbind p from previous-window
        unbind p

        # make Prefix p paste the buffer.
        bind p paste-buffer

        # Don't exit from tmux when closing a session
        set -g detach-on-destroy off

        # Renumber all windows when any window is closed
        set -g renumber-windows on

        # Tmux sessionizer
        bind -r f run-shell "tmux neww tmux-sessionizer-script"

        #--------------------------------------------------------------------------
        # Status Bar Gitmux
        #--------------------------------------------------------------------------

        # set -g status-left "#[fg=blue,bold]#S #[fg=white,nobold]#(${pkgs.gitmux}/bin/gitmux -cfg ${./gitmux.yml}) "
        # set -g status-right ""
        #
        # set -g status-left-length 300    # increase length (from 10)
        # set -g status-position top       # macOS / darwin style
        # set -g status-style 'bg=default' # transparent
        #
        # set -g window-status-current-format '*#[fg=magenta]#W'
        # set -g window-status-format ' #[fg=gray]#W'
        #
        # set -g allow-passthrough on
        # set -g message-command-style bg=default,fg=yellow
        # set -g message-style bg=default,fg=yellow
        # set -g mode-style bg=default,fg=yellow
        # set -g pane-active-border-style 'fg=white,bg=default'
        # set -g pane-border-style 'fg=brightblack,bg=default'
        #
        # bind '%' split-window -c '#{pane_current_path}' -h
        # bind '"' split-window -c '#{pane_current_path}'
        # bind c new-window -c '#{pane_current_path}'
        # TODO: repeat this for all bindings

        # bind -N "⌘+l last-session (via sesh) " L run-shell "sesh last || tmux display-message -d 1000 'Oops, no last sessions found'"
        # bind -N "⌘+9 switch to root session (via sesh) " 9 run-shell "sesh connect --root $(pwd)"
        #
        # bind -N "⌘+g lazygit " g new-window -c "#{pane_current_path}" -n "🌳" "lazygit 2> /dev/null"
        # bind -N "⌘+G gh-dash " G new-window -c "#{pane_current_path}" -n "😺" "ghd 2> /dev/null"
        # bind -N "⌘+b build" b split-window -v -l 10 build
        # bind -N "⌘+d dev" D split-window -v -l 10 dev
        # bind -N "⌘+R run a script" Y split-window -v -l 10 "npm run (jq -r '.scripts | keys[]' package.json | fzf --no-border)"
        # bind -N "⌘+Q kill current session" Q kill-session
        # bind -N "⌘+⇧+t break pane" B break-pane
        # bind -N "⌘+^+t join pane" J join-pane -t 1

        #--------------------------------------------------------------------------
        # Status Bar by conaN
        #--------------------------------------------------------------------------
        set -g @terminal_background             "#232634"
        set -g @terminal_foreground             "#c6d0f5"

        set -g @pane_active_border              "#838ba7"
        set -g @pane_inactive_border            "#414559"

        set -g @status_background               "#303446"
        set -g @status_foreground               "#c6d0f5"
        set -g @status_separator_left           ""
        set -g @status_separator_right          ""

        set -g @window_active_color             "#51576d"
        set -g @window_inactive_color           "#303446"
        set -g @window_separator_left           ""
        set -g @window_separator_right          ""

        set -g @session_normal_color            "#8caaee"
        set -g @session_prefix_color            "#a6d189"
        set -g @session_mode_color              "#e5c890"
        set -g @session_zoom_color              "#ca9ee6"

        set -g @directory_icon                  " "
        set -g @directory_icon_color            "#e5c890"

        set -g @git_icon                        " "
        set -g @git_icon_color                  "#a6d189"

        set -g @icon_nvim                       " "
        set -g @color_nvim                      "#81c8be"
        set -g @icon_fish                       " "
        set -g @color_fish                      "#ea999c"
        set -g @icon_yazi                       " "
        set -g @color_yazi                      "#e5c890"
        set -g @icon_lazygit                    " "
        set -g @color_lazygit                   "#a6d189"
        set -g @icon_neogit                     " "
        set -g @color_neogit                    "#cba6f7"
        set -g @icon_fallback                   " "
        set -g @color_fallback                  "#8caaee"
        #======================================================================================================================================================================================================================#
        set -g focus-events on
        set -g allow-passthrough on
        set -g monitor-bell off
        set -g visual-bell off

        set -g status-right-length 100
        set -g status-left-length 100
        set -g status 2
        set -g status-format[1] ""
        set -g status-interval 2
        set -g status-position top

        set -g status-style 'bg=default' # transparent
        # set -g status-style "bg=#{@terminal_background},fg=#{@terminal_foreground}" # Original, but I want to use transparency
        set -g mode-style "bg=#{@terminal_foreground},fg=#{@terminal_background}"
        set -g pane-active-border-style "bg=#{@terminal_background},fg=#{@pane_active_border}"
        set -g pane-border-style "bg=#{@terminal_background},fg=#{@pane_inactive_border}"
        #======================================================================================================================================================================================================================#
        set -g window-status-current-format "\
        #[fg=#{@window_active_color}]#[bg=#{@terminal_background}]#{@window_separator_left}\
        #[bg=#{@window_active_color}]\
        \
        #{?#{==:#{pane_current_command},nvim},#[fg=#{@color_nvim}]#{@icon_nvim}#[fg=#{@status_foreground}]#{pane_current_command},\
        #{?#{==:#{pane_current_command},fish},#[fg=#{@color_fish}]#{@icon_fish}#[fg=#{@status_foreground}]#{pane_current_command},\
        #{?#{==:#{pane_current_command},yazi},#[fg=#{@color_yazi}]#{@icon_yazi}#[fg=#{@status_foreground}]#{pane_current_command},\
        #{?#{==:#{pane_current_command},lazygit},#[fg=#{@color_lazygit}]#{@icon_lazygit}#[fg=#{@status_foreground}]#{pane_current_command},\
        \
        #[fg=#{@color_fallback}]#{@icon_fallback}#[fg=#{@status_foreground}]#{pane_current_command}}}}}\
        \
        #[fg=#{@window_active_color}]#[bg=#{@terminal_background}]#{@window_separator_right}"
        #======================================================================================================================================================================================================================#

        #======================================================================================================================================================================================================================#
        set -g window-status-format "\
        #[fg=#{@window_inactive_color}]#[bg=#{@terminal_background}]#{@window_separator_left}\
        #[bg=#{@window_inactive_color}]\
        \
        #{?#{==:#{pane_current_command},nvim},#[fg=#{@color_nvim}]#{@icon_nvim}#[fg=#{@status_foreground}]#{pane_current_command},\
        #{?#{==:#{pane_current_command},fish},#[fg=#{@color_fish}]#{@icon_fish}#[fg=#{@status_foreground}]#{pane_current_command},\
        #{?#{==:#{pane_current_command},yazi},#[fg=#{@color_yazi}]#{@icon_yazi}#[fg=#{@status_foreground}]#{pane_current_command},\
        #{?#{==:#{pane_current_command},lazygit},#[fg=#{@color_lazygit}]#{@icon_lazygit}#[fg=#{@status_foreground}]#{pane_current_command},\
        \
        #[fg=#{@color_fallback}]#{@icon_fallback}#[fg=#{@status_foreground}]#{pane_current_command}}}}}\
        \
        #[fg=#{@window_inactive_color}]#[bg=#{@terminal_background}]#{@window_separator_right}"
        #======================================================================================================================================================================================================================#

        #======================================================================================================================================================================================================================#
        set -g status-left "\
        #[fg=#{?client_prefix,#{@session_prefix_color},#{?pane_in_mode,#{@session_mode_color},#{?window_zoomed_flag,#{@session_zoom_color},#{@session_normal_color}}}},bg=#{@terminal_background}]#{@status_separator_left}\
        #[fg=#{@terminal_background},bg=#{?client_prefix,#{@session_prefix_color},#{?pane_in_mode,#{@session_mode_color},#{?window_zoomed_flag,#{@session_zoom_color},#{@session_normal_color}}}}]\
        #S\
        #[fg=#{?client_prefix,#{@session_prefix_color},#{?pane_in_mode,#{@session_mode_color},#{?window_zoomed_flag,#{@session_zoom_color},#{@session_normal_color}}}},bg=#{@terminal_background}]#{@status_separator_right}\
         "
        #======================================================================================================================================================================================================================#

        #======================================================================================================================================================================================================================#
        set -g status-right "\
         \
        #[fg=#{@status_background},bg=#{@terminal_background}]#{@status_separator_left}\
        #[fg=#{@directory_icon_color},bg=#{@status_background}]#{@directory_icon}\
        #[fg=#{@status_foreground},bg=#{@status_background}]\
        \
        #(echo #{pane_current_path} | sed 's|^$HOME|~|')\
        \
        #[fg=#{@status_background},bg=#{@terminal_background}]#{@status_separator_right}"

        set -ag status-right "\
         \
        #[fg=#{@status_background},bg=#{@terminal_background}]#{@status_separator_left}\
        #[fg=#{@git_icon_color},bg=#{@status_background}]#{@git_icon}\
        #[fg=#{@status_foreground},bg=#{@status_background}]\
        \
        #(git -C \"#{pane_current_path}\" branch --show-current 2>/dev/null || printf '·')\
        \
        #[fg=#{@status_background},bg=#{@terminal_background}]#{@status_separator_right}"
        #======================================================================================================================================================================================================================#
      '';
    };
    home.packages = with pkgs; [
      # https://frontendmasters.github.io/dev-prod-2/lessons/navigation/tmux
      tmux-sessionizer
      gitmux
      # Script to find files with tmux in vim
      (writeShellScriptBin "tmux-sessionizer-script" ''
        selected=$(find ~/work ~/ztm ~/personal ~/projects ~/opensource  -maxdepth 1 -mindepth 1 -type d | fzf)
        if [[ -z "$selected" ]]; then
            exit 0
        fi
        selected_name=$(basename $selected | tr ".,: " "____")

        switch_to() {
            if [[ -z "$TMUX" ]]; then
                tmux attach-session -t $selected_name
            else
                tmux switch-client -t $selected_name
            fi
        }

        if tmux has-session -t="$selected_name"; then
            switch_to
        else
            tmux new-session -ds $selected_name -c $selected
            switch_to
        fi
      '')
    ];
  };
}
