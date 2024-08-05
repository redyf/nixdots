{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./ags
    ./alacritty
    ./foot
    ./ghostty
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
    ags.enable = lib.mkDefault true;
    alacritty.enable = lib.mkDefault false;
    foot.enable = lib.mkDefault false;
    ghostty.enable = if pkgs.stdenv.isx86_64 then lib.mkDefault true else false;
    kitty.enable = if pkgs.stdenv.isAarch64 then lib.mkDefault true else false;
    rofi.enable = lib.mkDefault false;
    swww.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault false;
    wofi.enable = lib.mkDefault false;
  };
}
