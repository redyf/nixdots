{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.xfce;
in
{
  options.desktop.xfce = with types; {
    enable = mkBoolOpt false "Enable or disable xfce Desktop Environment";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
      };
      desktopManager = {
        xfce.enable = true;
      };
    };
  };
}
