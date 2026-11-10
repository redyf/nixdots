{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.xserver;
in
{
  options.myConfig.desktop.xserver = {
    enable = lib.mkEnableOption "xserver";
    displaySetup = lib.mkOption {
      type = lib.types.lines;
      default = "";
      example = "xrandr --output DP-0 --mode 1920x1080 --rate 165 --primary";
      description = "Host-specific monitor commands run at X session start (e.g. xrandr).";
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
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
