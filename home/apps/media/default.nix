{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.myHomeConfig.apps.media.enable = lib.mkEnableOption "media";
  config = lib.mkIf config.myHomeConfig.apps.media.enable {
    programs.obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override { cudaSupport = true; };
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };
    home = {
      packages = with pkgs; [
        playerctl
        pavucontrol
        mpv
        ffmpeg
        zathura
        imagemagick
      ];
    };
  };
}
