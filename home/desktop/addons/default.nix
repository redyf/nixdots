{
  lib,
  config,
  ...
}:
{
  imports = [
    ./ghostty
    ./quickshell
    ./swww
    ./waybar
    ./wezterm
    ./wofi
  ];
  options = {
    addons.enable = lib.mkEnableOption "Enable addons module";
  };
  config = lib.mkIf config.addons.enable {
    ghostty.enable = lib.mkDefault true;
    quickshell.enable = lib.mkDefault false;
    swww.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
    wezterm.enable = lib.mkDefault true;
    wofi.enable = lib.mkDefault true;
  };
}
