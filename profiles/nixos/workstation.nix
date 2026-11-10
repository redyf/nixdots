# Role: workstation — graphical machine with a user sitting in front of it.
{ inputs, lib, ... }:
{
  imports = [
    inputs.hyprland.nixosModules.default
    inputs.serpantinum.nixosModules.default
  ];

  programs.serpantinum.enable = lib.mkDefault true;

  myConfig = {
    desktop = {
      hyprland.enable = lib.mkDefault true;
      xserver.enable = lib.mkDefault true;
    };

    services = {
      displayManager.enable = lib.mkDefault true;
      input.enable = lib.mkDefault true;
    };

    system = {
      audio.enable = lib.mkDefault true;
      xdg-portal.enable = lib.mkDefault true;
    };

    themes.stylix.enable = lib.mkDefault true;
  };
}
