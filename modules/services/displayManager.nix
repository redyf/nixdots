{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.displayManager;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services = {
      displayManager =
        if pkgs.stdenv.isx86_64 then
          {
            enable = true;
            ly.enable = false;
            gdm.enable = true;
          }
        else
          { enable = false; };
    };
  };
}
