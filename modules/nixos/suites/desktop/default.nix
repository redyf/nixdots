{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.desktop;
in
{
  options.suites.desktop = with types; {
    enable = mkBoolOpt false "Enable the desktop suite";
  };

  config = mkIf cfg.enable {
    desktop = {
      hyprland = enabled;
      xfce = enabled;
      xmonad = enabled;
      addons = {
        foot = enabled;
        alacritty = enabled;
        bemenu = disabled;
        rofi = disabled;
        wofi = enabled;
        swww = enabled;
        wezterm = disabled;
        waybar = enabled;
        xdg-portal = enabled;
      };
    };
    services.xserver = {
      enable = true;
      displayManager.gdm = enabled;
    };
  };
}
