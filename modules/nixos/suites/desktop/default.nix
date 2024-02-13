{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.desktop;
in {
  options.suites.desktop = with types; {
    enable = mkBoolOpt false "Enable the desktop suite";
  };

  config = mkIf cfg.enable {
    apps = {
      firefox = enabled;
      floorp = enabled;
      spicetify = enabled;
    };
    desktop = {
      hyprland = enabled;
      xfce = enabled;
      xmonad = enabled;
      addons = {
        alacritty = enabled;
        bemenu = disabled;
        foot = disabled;
        kitty = enabled;
        rofi = disabled;
        st = enabled;
        swww = enabled;
        waybar = enabled;
        wezterm = disabled;
        wofi = enabled;
        xdg-portal = enabled;
      };
    };
    services.xserver = {
      enable = true;
      displayManager.gdm = enabled;
    };
  };
}
