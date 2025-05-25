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
      brave
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
      unzip
      ffmpeg_6
      polkit_gnome
      yazi
    ];
  };
}
