{ options
, inputs
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.addons.xdg-portal;
in
{
  options.desktop.addons.xdg-portal = with types; {
    enable = mkBoolOpt false "Whether or not to add support for xdg portal.";
  };

  config = mkIf cfg.enable {
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
        ];
      };
    };
  };
}
