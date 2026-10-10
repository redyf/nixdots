{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.displayManager;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services.displayManager = {
      enable = true;
      ly.enable = true;
    };
    security.pam.services.ly.enableGnomeKeyring = lib.mkIf (
      config.services.displayManager.ly.enable && config.services.gnome.gnome-keyring.enable
    ) true;
  };
}
