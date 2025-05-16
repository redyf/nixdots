{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.myConfig.programs.hyprland;
in
{
  config = lib.mkIf (config.myConfig.programs.enable && cfg.enable) {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = with pkgs; xdg-desktop-portal-hyprland;
    };
  };
}
