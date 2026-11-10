{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.input;
in
{
  options.myConfig.services.input.enable = lib.mkEnableOption "input";

  config = lib.mkIf cfg.enable {
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
