{
  lib,
  config,
  ...
}: {
  imports = [
    ./ags
    ./kitty
    ./swww
    ./waybar
    ./alacritty
    ./foot
    ./rofi
    ./wofi
  ];
  options = {
    addons.enable = lib.mkEnableOption "Enable addons module";
  };
  config = lib.mkIf config.addons.enable {
    ags.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    swww.enable = lib.mkDefault true;
    waybar.enable = lib.mkDefault false;
    alacritty.enable = lib.mkDefault false;
    foot.enable = lib.mkDefault false;
    rofi.enable = lib.mkDefault false;
    wofi.enable = lib.mkDefault false;
  };
}
