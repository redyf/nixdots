{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./foot
    ./ghostty
    ./hyprpanel
    ./kitty
    ./rofi
    ./swww
    ./waybar
    ./wofi
  ];
  options = {
    addons.enable = lib.mkEnableOption "Enable addons module";
  };
  config = lib.mkIf config.addons.enable {
    foot.enable = lib.mkDefault false;
    ghostty.enable = if pkgs.stdenv.isx86_64 then lib.mkDefault true else false;
    hyprpanel.enable = lib.mkDefault true;
    kitty.enable = if pkgs.stdenv.isAarch64 then lib.mkDefault true else true;
    rofi.enable = lib.mkDefault false;
    swww.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault false;
    wofi.enable = lib.mkDefault false;
  };
}
