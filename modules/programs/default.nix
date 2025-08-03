{ lib, ... }:

{
  options.myConfig.programs = {
    enable = lib.mkEnableOption "Enable programs configuration";

    hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland";
    };

    k3s = {
      enable = lib.mkEnableOption "Enable K3s";
    };

    nh = {
      enable = lib.mkEnableOption "Enable NH";
    };

    niri = {
      enable = lib.mkEnableOption "Enable Niri";
    };

    zsh = {
      enable = lib.mkEnableOption "Enable Zsh";
    };
  };

  imports = [
    ./hyprland.nix
    ./k3s.nix
    ./nh.nix
    ./niri.nix
    ./zsh.nix
  ];
}
