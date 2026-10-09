{ lib, ... }:

{
  options.myConfig.desktop = {
    enable = lib.mkEnableOption "Enable desktop configuration";

    gnome = {
      enable = lib.mkEnableOption "Enable gnome";
    };

    hyprland = {
      enable = lib.mkEnableOption "Enable hyprland";
    };

    i3 = {
      enable = lib.mkEnableOption "Enable i3";
    };

    kde = {
      enable = lib.mkEnableOption "Enable kde";
    };

    sway = {
      enable = lib.mkEnableOption "Enable sway";
    };

    xserver = {
      enable = lib.mkEnableOption "Enable xserver";
      displaySetup = lib.mkOption {
        type = lib.types.lines;
        default = "";
        example = "xrandr --output DP-0 --mode 1920x1080 --rate 165 --primary";
        description = "Host-specific monitor commands run at X session start (e.g. xrandr).";
      };
    };
  };

  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./i3.nix
    ./kde.nix
    ./sway.nix
    ./xserver.nix
  ];
}
