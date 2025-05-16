{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.audio;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    services = {
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        wireplumber.enable = true;
        jack.enable = false;
        pulse.enable = true;
        audio.enable = true;
      };
    };
  };
}
