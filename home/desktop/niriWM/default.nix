{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [ inputs.niri.homeModules.niri ];
  options = {
    niriWM.enable = lib.mkEnableOption "Enable Niri module";
  };
  config = lib.mkIf config.niriWM.enable {
    programs.niri = {
      enable = lib.mkDefault true;
      settings = {
        input = {
          keyboard = {
            repeat-delay = 140;
            repeat-rate = 30;
          };

          touchpad = {
            tap = true;
            accel-profile = "flat";
            natural-scroll = false;
          };

          mouse = {
            accel-profile = "flat";
            natural-scroll = false;
          };
        };
        hotkey-overlay.skip-at-startup = true;
        spawn-at-startup = [
          {
            command = [
              "autostart"
              "easyeffects --gapplication-service" # Starts easyeffects in the background
              "importGsettings"
            ];
          }
        ];
        animations = {
          enable = true;
        };
      };
    };
  };
}
