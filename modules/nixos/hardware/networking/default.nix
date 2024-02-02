{ options
, config
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.networking;
in
{
  options.hardware.networking = with types; {
    enable = mkBoolOpt false "Enable pipewire";
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      enableIPv6 = false;
      # no need to wait interfaces to have an IP to continue booting
      dhcpcd.wait = "background";
      # avoid checking if IP is already taken to boot a few seconds faster
      dhcpcd.extraConfig = "noarp";
      # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      # Configure network proxy if necessary
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };
  };
}
