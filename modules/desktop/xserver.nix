{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.xserver;
in
{
  config = lib.mkIf (config.myConfig.desktop.enable && cfg.enable) {
    services = {
      xserver = {
        enable = true;
        windowManager = {
          awesome.enable = false;
        };
        displayManager = {
          sessionCommands = ''
            xset r rate 150 30
            ${cfg.displaySetup}
            nitrogen --restore
          '';
        };
        # xkb layout: set by modules/system/keymap.nix from meta.nix.
      };
    };
  };
}
