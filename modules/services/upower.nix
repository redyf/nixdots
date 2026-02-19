{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.upower;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services = {
      upower = {
        enable = true;
      };
    };
  };
}
