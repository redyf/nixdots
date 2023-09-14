{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (wrapOBS {
      plugins = [
        obs-studio-plugins.wlrobs
        obs-studio-plugins.obs-vaapi
        obs-studio-plugins.obs-vkcapture
        obs-studio-plugins.obs-pipewire-audio-capture
      ];
    })
  ];
}
