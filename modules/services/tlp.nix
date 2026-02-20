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
    services = {
      tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
          CPU_SCALING_GOVERNOR_ON_AC = "performance";

          PLATFORM_PROFILE_ON_BAT = "low-power";
          PLATFORM_PROFILE_ON_AC = "performance";

          RUNTIME_PM_ON_BAT = "auto";
          RUNTIME_PM_ON_AC = "auto";

          WIFI_PWR_ON_BAT = "on";
        };
      };
    };
  };
}
