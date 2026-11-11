{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.gnome;
in
{
  options.myConfig.desktop.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.mkIf cfg.enable {
    services.desktopManager.gnome.enable = true;
  };
}
