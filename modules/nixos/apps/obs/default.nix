{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.obs;
in
{
  options.apps.obs = with types; {
    enable = mkBoolOpt false "Enable or disable the obs run launcher.";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };
  };
}
