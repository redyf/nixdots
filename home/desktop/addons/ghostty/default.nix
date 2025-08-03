{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    ghostty.enable = lib.mkEnableOption "Enable ghostty module";
  };
  config = lib.mkIf config.ghostty.enable {
    home = {
      packages = [ pkgs.ghostty ];
      file = {
        ".config/ghostty/config".text = ''
          # Fonts
          font-family = "MonoLisa"
          font-size = 16
          font-style = Medium 
          font-style-bold = Bold
          font-style-italic = Italic
          font-style-bold-italic = Bold Italic

          font-feature = ss01
          font-feature = ss02
          font-feature = ss04
          font-feature = ss07
          font-feature = ss08
          font-feature = ss10
          font-feature = ss11
          font-feature = ss13
          font-feature = ss18
          font-feature = zero
          # font-feature = ss01, ss02, ss04, ss07, ss08, ss10, ss11, ss13, ss18, zero # Monolisa
          # font-variation = "wght=800"
          font-thicken = true
          bold-is-bright = false

          # adjust-cell-width =
          # adjust-cell-height =
          # adjust-font-baseline =
          # adjust-underline-position =
          # adjust-underline-thickness = 1
          # adjust-strikethrough-position = 1
          # adjust-strikethrough-thickness = 1
          adjust-cursor-thickness = 10

          # Cursor
          # cursor-color =
          # cursor-opacity =
          # cursor-text =
          cursor-style = block
          cursor-style-blink = false
          cursor-click-to-move = false

          # Mouse
          mouse-hide-while-typing = false
          mouse-scroll-multiplier = 1

          # Screen
          background-opacity = 1
          unfocused-split-opacity = 0.7
          fullscreen = false

          # Window
          window-padding-x = 5
          window-padding-y = 5
          # window-padding-balance = false
          # window-inherit-working-directory = true
          # window-inherit-font-size = true
          # window-decoration = true
          # window-theme = auto
          # window-save-state = default
          # window-new-tab-position = current

          # Clipboard (ask, allow or deny)
          clipboard-read = ask
          clipboard-trim-trailing-spaces = true
          clipboard-paste-protection = true
          clipboard-paste-bracketed-safe = true
          copy-on-select = true

          # Close
          confirm-close-surface = false

          # Shell
          shell-integration = zsh
          shell-integration-features = cursor,no-sudo,title

          # GTK
          gtk-single-instance = desktop
          gtk-titlebar = false
          gtk-tabs-location = top
          gtk-wide-tabs = true

          theme = tokyonight-storm
        '';
      };
    };
  };
}
