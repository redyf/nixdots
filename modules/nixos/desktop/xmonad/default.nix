{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.xmonad;
in
{
  options.desktop.xmonad = with types; {
    enable = mkBoolOpt false "Enable or disable xmonad Window Manager";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
      };
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
    };
  };
}
