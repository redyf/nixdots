{ lib, config, ... }:
{
  imports = [
    ./browsers
    ./development
    ./file-explorer
    ./gaming
    ./media
    ./web
  ];

  options = {
    apps.enable = lib.mkEnableOption "Enable apps module";
  };
  config = lib.mkIf config.apps.enable {
    browsers.enable = lib.mkDefault true;
    file-explorer.enable = lib.mkDefault true;
    development.enable = lib.mkDefault true;
    gaming.enable = lib.mkDefault true;
    media.enable = lib.mkDefault true;
    web.enable = lib.mkDefault true;
  };
}
