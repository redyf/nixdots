{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.hyprland;
  hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.myConfig.desktop.hyprland.enable = lib.mkEnableOption "hyprland";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = hyprland.hyprland;
      portalPackage = hyprland.xdg-desktop-portal-hyprland;
    };
    services.gnome.gnome-keyring.enable = true;

    environment.sessionVariables = {
      # Temporary: keep core dumps (`coredumpctl info Hyprland`) in case it still dies.
      HYPRLAND_NO_CRASHREPORTER = "1";
    };
  };
}
