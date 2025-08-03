{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.systemd;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    # Change systemd stop job timeout in NixOS configuration (Default = 90s)
    systemd = {
      services.NetworkManager-wait-online.enable = false;
      settings.Manager = {
        DefaultTimeoutStopSec = "10s";
      };
    };
  };
}
