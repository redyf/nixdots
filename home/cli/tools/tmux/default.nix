{
  pkgs,
  lib,
  config,
  ...
}:
let
  theme = import ./theme.nix;
  themeConan = import ./theme-conan.nix { inherit pkgs; };
  macchiato = import ./macchiato.nix { inherit config; };
  primaryTmux = import ./primary-tmux.nix { inherit pkgs; };
in
{
  options.myHomeConfig.cli.tools.tmux.enable = lib.mkEnableOption "tmux";
  config = lib.mkIf config.myHomeConfig.cli.tools.tmux.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      baseIndex = 1;
      terminal = "tmux-256color";
      escapeTime = 0;
      keyMode = "vi";
      prefix = "C-Space";
      mouse = true;
      newSession = true;
      secureSocket = true;
      plugins =
        let
          tmuxPluginsList = with pkgs.tmuxPlugins; [
            yank
            sensible
            tmux-fzf
            vim-tmux-navigator
            {
              plugin = resurrect;
              extraConfig = "set -g @resurrect-strategy-nvim 'session'";
            }
          ];
        in
        tmuxPluginsList;
      extraConfig = ''
        set -ag terminal-overrides ",xterm-256color:RGB"

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
        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        unbind p

        bind p paste-buffer

        # Don't exit from tmux when closing a session
        set -g detach-on-destroy off

        # Renumber all windows when any window is closed
        set -g renumber-windows on

        # Extended keys
        set -g extended-keys on

        ${macchiato}
      '';
    };
  };
}
