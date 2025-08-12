{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.development.k3s;
in
{
  config = lib.mkIf (config.myConfig.development.enable && cfg.enable) {
    services.k3s = {
      enable = true;
    };
  };
}
