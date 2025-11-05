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

      # cpufreq = {
      #   min = 2900000;
      #   max = 4000000; # 4.3 GHz em kHz (turbo do i5-10400)
      # };
    };
    systemd.tmpfiles.rules = [
      "w /sys/devices/system/cpu/intel_pstate/min_perf_pct - - - - 75"
    ];
  };
}
