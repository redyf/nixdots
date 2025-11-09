{ lib, config, ... }:
let
  cfg = config.myHomeConfig.desktop;
in
{
  imports = [
    ./ghostty
    ./gnome
    ./hyprland
    ./noctalia
    ./niri
    ./rofi
    ./sway
    ./swww
    ./theme
    ./waybar
    ./wezterm
    ./wofi
  ];

  options.myHomeConfig.desktop = {
    enable = lib.mkEnableOption "desktop environment and window managers";
    ghostty.enable = lib.mkEnableOption "ghostty terminal";
    gnome.enable = lib.mkEnableOption "GNOME desktop environment";
    hyprland.enable = lib.mkEnableOption "Hyprland window manager";
    noctalia.enable = lib.mkEnableOption "Noctalia shell";
    niri.enable = lib.mkEnableOption "Niri window manager";
    rofi.enable = lib.mkEnableOption "Rofi launcher";
    sway.enable = lib.mkEnableOption "Sway window manager";
    swww.enable = lib.mkEnableOption "swww wallpaper daemon";
    theme.enable = lib.mkEnableOption "desktop theming";
    waybar.enable = lib.mkEnableOption "Waybar status bar";
    wezterm.enable = lib.mkEnableOption "WezTerm terminal";
    wofi.enable = lib.mkEnableOption "Wofi launcher";
  };

  config = lib.mkIf cfg.enable {
    ghostty.enable = lib.mkDefault cfg.ghostty.enable;
    gnome.enable = lib.mkDefault cfg.gnome.enable;
    hyprland.enable = lib.mkDefault cfg.hyprland.enable;
    noctalia.enable = lib.mkDefault cfg.noctalia.enable;
    niri.enable = lib.mkDefault cfg.niri.enable;
    rofi.enable = lib.mkDefault cfg.rofi.enable;
    sway.enable = lib.mkDefault cfg.sway.enable;
    swww.enable = lib.mkDefault cfg.swww.enable;
    theme.enable = lib.mkDefault cfg.theme.enable;
    waybar.enable = lib.mkDefault cfg.waybar.enable;
    wezterm.enable = lib.mkDefault cfg.wezterm.enable;
    wofi.enable = lib.mkDefault cfg.wofi.enable;
  };
}
