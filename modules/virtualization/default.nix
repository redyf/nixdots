{ lib, ... }:

{
  options.myConfig.virtualization = {
    enable = lib.mkEnableOption "Enable virtualization configuration";

    docker = {
      enable = lib.mkEnableOption "Enable Docker";
    };
  };
  imports = [
    ./docker.nix
  ];
}
