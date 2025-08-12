{
  lib,
  config,
  ...
}:
{
  imports = [
    ./ghostty
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
    swww.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
    wezterm.enable = lib.mkDefault true;
    wofi.enable = lib.mkDefault true;
  };
}
