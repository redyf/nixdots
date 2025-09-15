{ lib, ... }:

{
  options.myConfig.virtualization = {
    enable = lib.mkEnableOption "Enable virtualization configuration";

    docker = {
      enable = lib.mkEnableOption "Enable Docker";
    };

    virtmanager = {
      enable = lib.mkEnableOption "Enable VirtManager";
    };

    virtualbox = {
      enable = lib.mkEnableOption "Enable VirtualBox";
    };
  };
  imports = [
    ./docker.nix
    ./virtmanager.nix
    ./virtualbox.nix
  ];
}
