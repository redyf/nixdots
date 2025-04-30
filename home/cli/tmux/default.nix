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
        # Status Bar
        #--------------------------------------------------------------------------

        set -g status-left "#[fg=blue,bold]#S #[fg=white,nobold]#(${pkgs.gitmux}/bin/gitmux -cfg ${./gitmux.yml}) "
        # set -g status-right-length 80
        set -g status-right ""

        # set-option -g status 2
        # set -g status-format[1] '#[fg=blue,nobold][#(tmux ls -F "##S##{?session_attached,*,}" | tr "\n" "|" | sed "s/ $/ /" )]'

        set -g status-left-length 300    # increase length (from 10)
        set -g status-position top       # macOS / darwin style
        set -g status-style 'bg=default' # transparent

        set -g window-status-current-format '*#[fg=magenta]#W'
        set -g window-status-format ' #[fg=gray]#W'

        set -g allow-passthrough on
        set -g message-command-style bg=default,fg=yellow
        set -g message-style bg=default,fg=yellow
        set -g mode-style bg=default,fg=yellow
        set -g pane-active-border-style 'fg=white,bg=default'
        set -g pane-border-style 'fg=brightblack,bg=default'

        bind '%' split-window -c '#{pane_current_path}' -h
        bind '"' split-window -c '#{pane_current_path}'
        bind c new-window -c '#{pane_current_path}'
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
