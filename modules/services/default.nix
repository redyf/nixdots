{ lib, ... }:

{
  options.myConfig.services = {
    enable = lib.mkEnableOption "Enable Services configuration";

    services = {
      enable = lib.mkEnableOption "Enable services ";
    };
  };

  imports = [
    ./services.nix
  ];
}
