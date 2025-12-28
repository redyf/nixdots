{ lib, ... }:

{
  options.myConfig.desktop = {
    enable = lib.mkEnableOption "Enable desktop configuration";

    hyprland = {
      enable = lib.mkEnableOption "Enable hyprland";
    };

    i3 = {
      enable = lib.mkEnableOption "Enable i3";
    };

    sway = {
      enable = lib.mkEnableOption "Enable sway";
    };

    xserver = {
      enable = lib.mkEnableOption "Enable xserver";
    };
  };

  imports = [
    ./hyprland.nix
    ./i3.nix
    ./sway.nix
    ./xserver.nix
  ];
}
