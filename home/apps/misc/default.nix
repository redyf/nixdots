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
      # prismlauncher

      # Gamedev
      godot_4
      # unityhub
      # aseprite

      # Other stuff
      playerctl
      pavucontrol
      zathura
      realvnc-vnc-viewer
      google-chrome

      # Extra utils
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
