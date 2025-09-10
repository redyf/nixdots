{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.xserver;
in
{
  config = lib.mkIf (config.myConfig.desktop.enable && cfg.enable) {
    services = {
      xserver = {
        enable = true;
        windowManager = {
          awesome.enable = false;
        };
        displayManager = {
          sessionCommands = ''
            xset r rate 140 30
            xrandr --output DP-0 --mode 1920x1080 --rate 165 --primary
            nitrogen --restore
          '';
        };
        xkb = {
          variant = "";
          layout = "br";
        };
      };
    };
  };
}
