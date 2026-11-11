{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.development.k3s;
in
{
  options.myConfig.development.k3s.enable = lib.mkEnableOption "K3s";

  config = lib.mkIf cfg.enable {
    services.k3s = {
      enable = true;
      # Bind API server to loopback only — prevents port 6443 from being exposed on the network
      extraFlags = "--bind-address=127.0.0.1 --node-ip=127.0.0.1";
    };
  };
}
