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
          font-family = "TX-02"
          font-size = 14
          font-style = Medium 
          font-style-bold = Bold
          font-style-italic = Italic
          font-style-bold-italic = Bold Italic
          font-thicken = true
          bold-is-bright = false

          adjust-cursor-thickness = 10

          cursor-style = block
          cursor-style-blink = false
          cursor-click-to-move = false

          mouse-hide-while-typing = false
          mouse-scroll-multiplier = 1

          background-blur = 255
          background-opacity = 0.8
          fullscreen = false

          window-padding-x = 5
          window-padding-y = 5

          confirm-close-surface = false

          shell-integration = zsh
          shell-integration-features = cursor,no-sudo,title

          gtk-single-instance = desktop
          gtk-titlebar = false
          gtk-tabs-location = top
          gtk-wide-tabs = true

          theme = tokyonight_moon
        '';
      };
    };
  };
}
