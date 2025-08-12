{ lib, ... }:

{
  options.myConfig.programs = {
    enable = lib.mkEnableOption "Enable programs configuration";

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
