{ lib, ... }:

{
  options.myConfig.cli = {
    enable = lib.mkEnableOption "Enable cli configuration";

    appimage = {
      enable = lib.mkEnableOption "Enable appimage-run";
    };

    nh = {
      enable = lib.mkEnableOption "Enable NH";
      flakePath = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Path to the flake used by nh. Defaults to ~/opensource/nixdots.";
      };
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
