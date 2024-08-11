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
      # ani-cli # A cli tool to browse and play anime
      # mangal # A fancy CLI app written in Go which scrapes, downloads and packs manga into different formats

      # Gaming
      # gnutls
      # minecraft
      # grapejuice
      # libpulseaudio

      # Other stuff
      playerctl
      zathura

      # Extra utils
      bitwarden-desktop
      wget
      parted
      mpv
      glib
      unzip # Unzip files using the terminal
      ffmpeg_6 # A complete, cross-platform solution to record, convert and stream audio and video
      tree-sitter # A parser generator tool and an incremental parsing library
      appimage-run # Run appimage files in the terminal
      polkit_gnome
      pcmanfm
    ];
  };
}
