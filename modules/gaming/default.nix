{ lib, ... }:

{
  options.myConfig.gaming = {
    enable = lib.mkEnableOption "Enable gaming configuration";

    steam = {
      enable = lib.mkEnableOption "Enable Steam gaming platform";
    };
  };

  imports = [
    ./steam.nix
  ];
}
