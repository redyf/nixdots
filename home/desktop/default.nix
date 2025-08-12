{ lib, config, ... }:
{
  imports = [
    ./ghostty
    ./hyprland
    ./niri
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
    hyprland.enable = lib.mkDefault true;
    niri.enable = lib.mkDefault true;
    swww.enable = lib.mkDefault true;
    theme.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
    wezterm.enable = lib.mkDefault true;
    wofi.enable = lib.mkDefault true;
  };
}
