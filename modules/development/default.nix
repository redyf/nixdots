{ lib, ... }:

{
  options.myConfig.development = {
    enable = lib.mkEnableOption "Enable development configuration";

    k3s = {
      enable = lib.mkEnableOption "Enable K3s";
    };
  };

  imports = [
    ./k3s.nix
  ];
}
