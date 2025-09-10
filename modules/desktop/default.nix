{ lib, ... }:

{
  options.myConfig.desktop = {
    enable = lib.mkEnableOption "Enable desktop configuration";

    gnome = {
      enable = lib.mkEnableOption "Enable gnome";
    };

    hyprland = {
      enable = lib.mkEnableOption "Enable hyprland";
    };

    niri = {
      enable = lib.mkEnableOption "Enable niri";
    };

    xserver = {
      enable = lib.mkEnableOption "Enable xserver";
    };
  };

  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./niri.nix
    ./xserver.nix
  ];
}
