{ lib, ... }:

{
  options.myConfig.cli = {
    enable = lib.mkEnableOption "Enable cli configuration";

    nh = {
      enable = lib.mkEnableOption "Enable NH";
    };

    zsh = {
      enable = lib.mkEnableOption "Enable Zsh";
    };
  };

  imports = [
    ./nh.nix
    ./zsh.nix
  ];
}
