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
    # TODO: Break this into multiple modules
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
      zathura
      appimage-run
      wget
      parted
      unzip
      polkit_gnome
      yazi
    ];
  };
}
