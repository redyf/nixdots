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
  options.myConfig.desktop.hyprland.enable = lib.mkEnableOption "hyprland";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    services.gnome.gnome-keyring.enable = true;
  };
}
