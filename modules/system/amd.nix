{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.amd;
in
{
  options.myConfig.system.amd.enable = lib.mkEnableOption "amd module";

  config = lib.mkIf cfg.enable {
    boot = {
      initrd.kernelModules = [ "amdgpu" ];
      kernelParams = [ "amd_pstate=active" ];
    };
  };
}
