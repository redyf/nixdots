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
      # nyaa
      jetbrains.idea-ultimate
      ani-cli
      anydesk
      awscli2
      cava
      google-chrome
      postman
      beekeeper-studio
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
