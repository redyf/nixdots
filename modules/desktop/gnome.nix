{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.gnome;
in
{
  config = lib.mkIf (config.myConfig.desktop.enable && cfg.enable) {
    services.desktopManager.gnome.enable = true;
  };
}
