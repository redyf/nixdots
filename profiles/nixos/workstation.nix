# Role: workstation — graphical machine with a user sitting in front of it.
{ lib, ... }:
{
  myConfig = {
    desktop = {
      enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault true;
      xserver.enable = lib.mkDefault true;
    };

    services = {
      enable = lib.mkDefault true;
      displayManager.enable = lib.mkDefault true;
      flatpak.enable = lib.mkDefault false;
      input.enable = lib.mkDefault true;
    };

    system = {
      audio.enable = lib.mkDefault true;
      xdg-portal.enable = lib.mkDefault true;
    };

    themes = {
      enable = lib.mkDefault true;
      stylix.enable = lib.mkDefault true;
    };
  };
}
