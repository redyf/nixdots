{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.services;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    # TODO: Split into multiple modules
    services = {
      fstrim.enable = true;
      flatpak.enable = true;
      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
        };
        touchpad = {
          accelProfile = "flat";
        };
      };
      displayManager =
        if pkgs.stdenv.isx86_64 then
          {
            enable = true;
            ly.enable = true;
          }
        else
          { enable = false; };
      autorandr = {
        enable = true;
        profiles = {
          redyf = {
            config = {
              DP-0 = {
                enable = true;
                primary = true;
                mode = "1920x1080";
                rate = "165.00";
                position = "0x0";
              };
            };
          };
        };
      };
    };
  };
}
