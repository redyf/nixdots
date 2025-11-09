{ lib, config, ... }:
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

  options = {
    desktop.enable = lib.mkEnableOption "Enable desktop module";
  };
  config = lib.mkIf config.desktop.enable {
    ghostty.enable = lib.mkDefault true;
    gnome.enable = lib.mkDefault false;
    hyprland.enable = lib.mkDefault true;
    noctalia.enable = lib.mkDefault true;
    niri.enable = lib.mkDefault false;
    rofi.enable = lib.mkDefault false;
    sway.enable = lib.mkDefault false;
    swww.enable = lib.mkDefault false;
    theme.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault false;
    wezterm.enable = lib.mkDefault false;
    wofi.enable = lib.mkDefault true;
  };
}
