{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.tlp;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";

        PLATFORM_PROFILE_ON_BAT = "low-power";
        PLATFORM_PROFILE_ON_AC = "performance";

        RUNTIME_PM_ON_BAT = "auto";
        RUNTIME_PM_ON_AC = "auto";

        PCIE_ASPM_ON_BAT = "powersupersave";
        PCIE_ASPM_ON_AC = "default";

        USB_AUTOSUSPEND = "1";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
        CPU_BOOST_ON_BAT = "0";
        CPU_BOOST_ON_AC  = "1";

        WIFI_PWR_ON_BAT = "on";
        WIFI_PWR_ON_AC  = "off";
      };
    };
  };
}
