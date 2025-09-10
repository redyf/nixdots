{ lib, ... }:

{
  options.myConfig.virtualization = {
    enable = lib.mkEnableOption "Enable virtualization configuration";

    docker = {
      enable = lib.mkEnableOption "Enable Docker";
    };

    virtualbox = {
      enable = lib.mkEnableOption "Enable VirtualBox";
    };
  };
  imports = [
    ./docker.nix
    ./virtualbox.nix
  ];
}
