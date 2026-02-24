{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.intel;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    boot = {
      kernelParams = [
        "intel_pstate=passive"
      ];
    };
  };
}
