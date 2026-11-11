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
  options.myConfig.desktop.i3.enable = lib.mkEnableOption "i3";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.rofi ];
    services.xserver.windowManager.i3 = {
      enable = true;
      configFile = ./config;
    };
  };
}
