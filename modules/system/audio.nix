{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.audio;
in
{
  options.myConfig.system.audio.enable = lib.mkEnableOption "audio";

  config = lib.mkIf cfg.enable {
    services = {
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
      };
    };
  };
}
