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
    ./wofi
  ];
  options = {
    addons.enable = lib.mkEnableOption "Enable addons module";
  };
  config = lib.mkIf config.addons.enable {
    ghostty.enable = if pkgs.stdenv.isx86_64 then lib.mkDefault false else false;
    hyprpanel.enable = lib.mkDefault true;
    kitty.enable = if pkgs.stdenv.isAarch64 then lib.mkDefault true else true;
    swww.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault false;
    wofi.enable = lib.mkDefault true;
  };
}
