{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.networking;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    networking = {
      networkmanager = {
        enable = true;
        wifi.powersave = false;
      };
      firewall.enable = true;
      # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      # Configure network proxy if necessary
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };
  };
}
