{ lib, config, ... }:
{
  imports = [
    ./development
    ./gaming
    ./media
    ./web
  ];

  options = {
    apps.enable = lib.mkEnableOption "Enable apps module";
  };
  config = lib.mkIf config.apps.enable {
    development.enable = lib.mkDefault true;
    gaming.enable = lib.mkDefault true;
    media.enable = lib.mkDefault true;
    web.enable = lib.mkDefault true;
  };
}
