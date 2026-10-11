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
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      # Fallback for sessions without their own <desktop>-portals.conf (e.g.
      # i3). Hyprland and Sway ship/set their own.
      config.common.default = [ "gtk" ];
    };
  };
}
