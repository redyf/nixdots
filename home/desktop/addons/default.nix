{
  lib,
  config,
  ...
}: {
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
    ghostty.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault false;
    swww.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault false;
    wofi.enable = lib.mkDefault false;
  };
}
