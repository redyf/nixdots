{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.amd;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    boot.initrd.kernelModules = [ "amdgpu" ];
  };
}
