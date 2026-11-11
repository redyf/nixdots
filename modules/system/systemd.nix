{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.systemd;
in
{
  options.myConfig.system.systemd.enable = lib.mkEnableOption "systemd";

  config = lib.mkIf cfg.enable {
    systemd = {
      services.NetworkManager-wait-online.enable = false;
      settings.Manager = {
        DefaultTimeoutStopSec = "10s";
      };
    };
  };
}
