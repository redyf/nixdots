{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.xserver;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services = {
      xserver = {
        enable = true;
        windowManager = {
          awesome.enable = true;
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
