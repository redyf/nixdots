{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.development.k8s;
in
{
  config = lib.mkIf (config.myConfig.development.enable && cfg.enable) {
    environment.systemPackages = with pkgs; [
      kubectl
      minikube
    ];
  };
}
