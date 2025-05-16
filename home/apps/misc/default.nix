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
      # Gaming
      # prismlauncher

      # nyaa
      awscli2
      xfce.thunar
      httpie
      ngrok
      qbittorrent
      playerctl
      pavucontrol
      zathura
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
