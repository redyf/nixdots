{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.networking;
in
{
  options.myConfig.system.networking.enable = lib.mkEnableOption "networking";

  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = true;
        wifi.powersave = false;
      };
    };
  };
}
