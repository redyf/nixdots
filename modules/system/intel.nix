{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.intel;
in
{
  options.myConfig.system.intel.enable = lib.mkEnableOption "intel kernel params";

  config = lib.mkIf cfg.enable {
    boot = {
      kernelParams = [
        "intel_pstate=passive"
      ];
    };
  };
}
