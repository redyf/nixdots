{ lib, ... }:

{
  options.myConfig.development = {
    enable = lib.mkEnableOption "Enable development configuration";

    k3s = {
      enable = lib.mkEnableOption "Enable K3s";
    };

    k8s = {
      enable = lib.mkEnableOption "Enable K8s";
    };
  };

  imports = [
    ./k3s.nix
    ./k8s.nix
  ];
}
