{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.flatpak;
in
{
  options.myConfig.services.flatpak.enable = lib.mkEnableOption "flatpak";

  config = lib.mkIf cfg.enable {
    services = {
      flatpak.enable = true;
    };
  };
}
