{ lib, config, ... }:
let
  cfg = config.myHomeConfig.apps;
in
{
  imports = [
    ./browsers
    ./development
    ./file-explorer
    ./gaming
    ./media
    ./web
  ];

  options.myHomeConfig.apps = {
    enable = lib.mkEnableOption "applications and GUI programs";
    browsers.enable = lib.mkEnableOption "web browsers";
    development.enable = lib.mkEnableOption "development applications";
    file-explorer.enable = lib.mkEnableOption "file explorer applications";
    gaming.enable = lib.mkEnableOption "gaming applications";
    media.enable = lib.mkEnableOption "media applications";
    web.enable = lib.mkEnableOption "web applications";
  };

  config = lib.mkIf cfg.enable {
    browsers.enable = lib.mkDefault cfg.browsers.enable;
    development.enable = lib.mkDefault cfg.development.enable;
    file-explorer.enable = lib.mkDefault cfg.file-explorer.enable;
    gaming.enable = lib.mkDefault cfg.gaming.enable;
    media.enable = lib.mkDefault cfg.media.enable;
    web.enable = lib.mkDefault cfg.web.enable;
  };
}
