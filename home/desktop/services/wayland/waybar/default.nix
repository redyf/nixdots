{
  pkgs,
  lib,
  config,
  osConfig,
  inputs,
  ...
}:
with lib; let
  waybar_config = import ./config.nix {inherit osConfig config lib pkgs;};
  waybar_style = import ./style.nix {inherit (config) colorscheme;};
  # waybar_config = import ./config2/config.nix {inherit osConfig config lib pkgs;};
  # waybar_style = import ./config2/style.nix {inherit (config) colorscheme;};
in {
  home.packages = with pkgs; [
    python39Packages.requests
  ];
  programs.waybar = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
    settings = waybar_config;
    style = waybar_style;
  };
}
