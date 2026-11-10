{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.tailscale;
in
{
  options.myConfig.system.tailscale.enable = lib.mkEnableOption "tailscale";

  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;
  };
}
