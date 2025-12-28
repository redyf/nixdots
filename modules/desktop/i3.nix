{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.desktop.i3;
in
{
  config = lib.mkIf (config.myConfig.desktop.enable && cfg.enable) {
    environment.systemPackages = [ pkgs.rofi ];
    services.xserver.windowManager.i3 = {
      enable = true;
      configFile = ./config;
    };
  };
}
