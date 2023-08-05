{
  pkgs,
  lib,
  config,
  osConfig,
  inputs,
  ...
}:
with lib; let
  # Bar v1
  # waybar_config = import ./config.nix {inherit osConfig config lib pkgs;};
  # waybar_style = import ./style.nix {inherit (config) colorscheme;};
  # Bar v2
  # waybar_config = import ./config2/config.nix {inherit osConfig config lib pkgs;};
  # waybar_style = import ./config2/style.nix {inherit (config) colorscheme;};
  # Bar V3
  waybar_config = import ./nixbar/config.nix {inherit osConfig config lib pkgs;};
  waybar_style = import ./nixbar/style.nix {inherit (config) colorscheme;};
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
