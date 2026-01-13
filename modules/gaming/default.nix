{ lib, ... }:

{
  options.myConfig.gaming = {
    enable = lib.mkEnableOption "Enable gaming configuration";

    gamescope = {
      enable = lib.mkEnableOption "Enable gamescope";
    };

    steam = {
      enable = lib.mkEnableOption "Enable Steam gaming platform";
    };
  };

  imports = [
    ./gamescope.nix
    ./steam.nix
  ];
}
