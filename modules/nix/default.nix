{ lib, ... }:

{
  options.myConfig.nix = {
    enable = lib.mkEnableOption "Enable Global Nix configuration";

    nix = {
      enable = lib.mkEnableOption "Enable nix ";
    };
  };

  imports = [
    ./nix.nix
  ];
}
