{ lib, config, ... }:
let
  cfg = config.myHomeConfig.desktop;
in
{
  imports = [
    ./foot
    ./ghostty
    ./gtk
    ./hyprland
    ./noctalia
    ./rofi
    ./sway
    ./swww
    ./stylix
    ./waybar
    ./wezterm
    ./wofi
  ];

  options.myHomeConfig.desktop = {
    enable = lib.mkEnableOption "desktop environment and window managers";
    foot.enable = lib.mkEnableOption "foo terminal";
    ghostty.enable = lib.mkEnableOption "ghostty terminal";
    gtk-theme.enable = lib.mkEnableOption "GTK theming";
    hyprland.enable = lib.mkEnableOption "Hyprland window manager";
    noctalia.enable = lib.mkEnableOption "Noctalia shell";
    rofi.enable = lib.mkEnableOption "Rofi launcher";
    sway.enable = lib.mkEnableOption "Sway window manager";
    swww.enable = lib.mkEnableOption "swww wallpaper daemon";
    stylix-theme.enable = lib.mkEnableOption "stylix theming";
    waybar.enable = lib.mkEnableOption "Waybar status bar";
    wezterm.enable = lib.mkEnableOption "WezTerm terminal";
    wofi.enable = lib.mkEnableOption "Wofi launcher";
  };

  config = lib.mkIf cfg.enable {
    foot.enable = lib.mkDefault cfg.foot.enable;
    ghostty.enable = lib.mkDefault cfg.ghostty.enable;
    gtk-theme.enable = lib.mkDefault cfg.gtk-theme.enable;
    hyprland.enable = lib.mkDefault cfg.hyprland.enable;
    noctalia.enable = lib.mkDefault cfg.noctalia.enable;
    rofi.enable = lib.mkDefault cfg.rofi.enable;
    sway.enable = lib.mkDefault cfg.sway.enable;
    swww.enable = lib.mkDefault cfg.swww.enable;
    stylix-theme.enable = lib.mkDefault cfg.stylix-theme.enable;
    waybar.enable = lib.mkDefault cfg.waybar.enable;
    wezterm.enable = lib.mkDefault cfg.wezterm.enable;
    wofi.enable = lib.mkDefault cfg.wofi.enable;
  };
}
