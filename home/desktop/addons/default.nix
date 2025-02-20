{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./ghostty
    ./hyprpanel
    ./kitty
    ./swww
    ./waybar
    ./wezterm
    ./wofi
  ];
  options = {
    addons.enable = lib.mkEnableOption "Enable addons module";
  };
  config = lib.mkIf config.addons.enable {
    ghostty.enable = if pkgs.stdenv.isx86_64 then lib.mkDefault false else false;
    hyprpanel.enable = lib.mkDefault false;
    kitty.enable = if pkgs.stdenv.isAarch64 then lib.mkDefault true else true;
    swww.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault true;
    wezterm.enable = lib.mkDefault true;
    wofi.enable = lib.mkDefault true;
  };
}
