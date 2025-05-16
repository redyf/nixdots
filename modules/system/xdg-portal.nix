{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.xdg-portal;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
      ];
    };
  };
}
