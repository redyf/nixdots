{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    media.enable = lib.mkEnableOption "Enable media module";
  };
  config = lib.mkIf config.media.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };
    home.packages = with pkgs; [
      playerctl
      pavucontrol
      mpv
      ffmpeg_6
    ];
  };
}
