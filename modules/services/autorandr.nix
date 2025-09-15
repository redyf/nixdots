{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.autorandr;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services = {
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
