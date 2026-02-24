{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.kernel;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    boot = {
      kernelPackages = pkgs.linuxPackages;
    };
  };
}
