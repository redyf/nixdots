{ lib, ... }:

{
  options.myConfig.desktop = {
    enable = lib.mkEnableOption "Enable desktop configuration";

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
    ./hyprland.nix
    ./niri.nix
    ./xserver.nix
  ];
}
