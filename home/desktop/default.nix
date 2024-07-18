{
  lib,
  config,
  ...
}: {
  imports = [
    ./addons
    ./theme
    ./hyprland
    ./awesomewm.nix
  ];

  options = {
    desktop.enable = lib.mkEnableOption "Enable desktop module";
  };
  config = lib.mkIf config.desktop.enable {
    addons.enable = lib.mkDefault true;
    theme.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    awesomewm.enable = lib.mkDefault false;
  };
}
