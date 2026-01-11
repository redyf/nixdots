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

    kde = {
      enable = lib.mkEnableOption "Enable kde";
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
    ./kde.nix
    ./sway.nix
    ./xserver.nix
  ];
}
