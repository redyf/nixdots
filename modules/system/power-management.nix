{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.power-management;
in
{
  options.myConfig.system.power-management.enable = lib.mkEnableOption "power-management";

  config = lib.mkIf cfg.enable {
    powerManagement = {
      enable = false;
      cpuFreqGovernor = "performance";
    };
    # intel_pstate sysfs only exists on Intel CPUs.
    systemd.tmpfiles.rules = lib.mkIf config.myConfig.system.intel.enable [
      "w /sys/devices/system/cpu/intel_pstate/min_perf_pct - - - - 75"
    ];
  };
}
