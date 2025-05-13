{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./swww
    ./waybar
    ./wezterm
    ./wofi
  ];
  options = {
    addons.enable = lib.mkEnableOption "Enable addons module";
  };
  config = lib.mkIf config.addons.enable {
    swww.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault false;
    wezterm.enable = lib.mkDefault true;
    wofi.enable = lib.mkDefault true;
  };
}
