{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.upower;
in
{
  options.myConfig.services.upower.enable = lib.mkEnableOption "Upower";

  config = lib.mkIf cfg.enable {
    services = {
      upower = {
        enable = true;
      };
    };
  };
}
