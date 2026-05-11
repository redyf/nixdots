{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.tailscale;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    services.tailscale.enable = true;
  };
}
