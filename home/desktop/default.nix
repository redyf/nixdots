{ lib, config, ... }:
{
  imports = [
    ./addons
    ./theme
    ./hyprland
  ];

  options = {
    desktop.enable = lib.mkEnableOption "Enable desktop module";
  };
  config = lib.mkIf config.desktop.enable {
    addons.enable = lib.mkDefault true;
    theme.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
  };
}
