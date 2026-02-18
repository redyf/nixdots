{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.power-management;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    powerManagement = {
      enable = false;
      cpuFreqGovernor = "performance";
    };
    systemd.tmpfiles.rules = [
      "w /sys/devices/system/cpu/intel_pstate/min_perf_pct - - - - 75"
    ];
  };
}
