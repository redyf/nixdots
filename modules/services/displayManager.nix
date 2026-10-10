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
            ly.enable = true;
          }
        else
          { enable = false; };
    };
    # Unlock the GNOME keyring with the login password.
    security.pam.services.ly.enableGnomeKeyring = lib.mkIf (
      config.services.displayManager.ly.enable && config.services.gnome.gnome-keyring.enable
    ) true;
  };
}
