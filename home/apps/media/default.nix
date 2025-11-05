{
  inputs,
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
        ffmpeg_6
        blender
        zathura
        qbittorrent
      ];
      # file = {
      #   ".config/obs-studio/themes/" = {
      #     source =
      #       pkgs.fetchFromGitHub {
      #         owner = "catppuccin";
      #         repo = "obs";
      #         rev = "05c55ffe499c183c98be469147f602c3f8e84b87";
      #         hash = "sha256-ezz3euxO5lxyVaVFDPjNowpivAm9tRGHt8SbflAdkA8=";
      #       }
      #       + "/themes";
      #   };
      #   ".config/blender/4.5/scripts/presets/interface_theme/" = {
      #     source =
      #       pkgs.fetchFromGitHub {
      #         owner = "Dalibor-P";
      #         repo = "blender";
      #         rev = "13581d8296249a62368e14ee66868f9100f19b5a";
      #         hash = "sha256-BHlSjtr8+5+kgjIoVIUwiJ6iyEPMR2G+9x2vWgMNoew=";
      #       }
      #       + "/themes";
      #   };
      # };
    };
  };
}
