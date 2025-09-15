{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.flatpak;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services = {
      flatpak.enable = true;
    };
  };
}
