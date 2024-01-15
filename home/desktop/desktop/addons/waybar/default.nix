{ pkgs
, lib
, config
, osConfig
, ...
}:
with lib; let
  # Bar v1
  # waybar_config = import ./config.nix {inherit osConfig config lib pkgs;};
  # waybar_style = import ./style.nix {inherit (config) colorscheme;};
  # NixBar
  # waybar_config = import ./nixbar/config.nix {inherit osConfig config lib pkgs;};
  # waybar_style = import ./nixbar/style.nix {inherit (config) colorscheme;};
  # Tokyonight
  # waybar_config = import ./tokyonight/config.nix {inherit osConfig config lib pkgs;};
  # waybar_style = import ./tokyonight/style.nix {inherit (config) colorscheme;};
  waybar_config = import ./catppuccin/config.nix { inherit osConfig config lib pkgs; };
  waybar_style = import ./catppuccin/style.nix { inherit (config) colorscheme; };
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = waybar_config;
    style = waybar_style;
  };
}
