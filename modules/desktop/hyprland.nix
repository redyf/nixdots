{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.hyprland;
in
{
  config = lib.mkIf (config.myConfig.desktop.enable && cfg.enable) {
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    # Secret Service (org.freedesktop.secrets) for apps using libsecret/keytar, e.g. Inkdrop.
    services.gnome.gnome-keyring.enable = true;
  };
}
