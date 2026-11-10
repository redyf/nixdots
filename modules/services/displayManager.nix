{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.displayManager;
in
{
  options.myConfig.services.displayManager.enable = lib.mkEnableOption "displayManager";

  config = lib.mkIf cfg.enable {
    services.displayManager = {
      enable = true;
      ly.enable = true;
    };
    security.pam.services.ly.enableGnomeKeyring = lib.mkIf (
      config.services.displayManager.ly.enable && config.services.gnome.gnome-keyring.enable
    ) true;
  };
}
