{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.gnome;
in
{
  config = lib.mkIf (config.myConfig.desktop.enable && cfg.enable) {
    services.desktopManager.gnome = {
      enable = true;
    };
    programs = {
      dconf.enable = true;
    };
    environment.gnome.excludePackages = with pkgs; [
      gedit
      gnome-software
      gnome-music
      eog
      simple-scan
      totem
      epiphany
      geary
      gnome-tour
      tali
      yelp
      gnome-maps
      gnome-contacts
      gnome-terminal
    ];
  };
}
