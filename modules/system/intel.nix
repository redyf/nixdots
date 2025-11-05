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
    hardware = {
      graphics = {
        enable = true;
        # extraPackages = with pkgs; [
        #   intel-media-driver # For Intel integrated graphics
        #   intel-vaapi-driver # Intel video acceleration
        # ];
      };
    };
  };
}
