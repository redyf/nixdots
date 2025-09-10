{ lib, ... }:

{
  options.myConfig.cli = {
    enable = lib.mkEnableOption "Enable cli configuration";

    appimage = {
      enable = lib.mkEnableOption "Enable appimage-run";
    };

    nh = {
      enable = lib.mkEnableOption "Enable NH";
    };

    zsh = {
      enable = lib.mkEnableOption "Enable Zsh";
    };
  };

  imports = [
    ./appimage.nix
    ./nh.nix
    ./zsh.nix
  ];
}
