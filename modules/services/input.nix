{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.input;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services = {
      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
        };
        touchpad = {
          accelProfile = "flat";
        };
      };
    };
  };
}
