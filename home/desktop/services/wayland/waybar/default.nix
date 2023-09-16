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
  waybar_config = import ./config.nix {inherit osConfig config lib pkgs;};
  waybar_style = import ./style.nix {inherit (config) colorscheme;};
  # NixBar
  # waybar_config = import ./nixbar/config.nix {inherit osConfig config lib pkgs;};
  # waybar_style = import ./nixbar/style.nix {inherit (config) colorscheme;};
in {
  home.packages = with pkgs; [
    python39Packages.requests
  ];
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = waybar_config;
    style = waybar_style;
  };
}
