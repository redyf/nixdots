{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    misc.enable = lib.mkEnableOption "Enable misc module";
  };
  config = lib.mkIf config.misc.enable {
    home.packages = with pkgs; [
      # Anime/Manga
      # mangal # A fancy CLI app written in Go which scrapes, downloads and packs manga into different formats

      # Gaming
      # prismlauncher

      # Other stuff
      # nyaa
      qbittorrent
      insomnia
      beekeeper-studio
      playerctl
      pavucontrol
      zathura
      realvnc-vnc-viewer
      appimage-run
      wget
      parted
      mpv
      unzip # Unzip files using the terminal
      ffmpeg_6 # A complete, cross-platform solution to record, convert and stream audio and video
      polkit_gnome
      yazi
    ];
  };
}
