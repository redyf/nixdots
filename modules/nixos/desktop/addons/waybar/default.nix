{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.addons.waybar;
  # Bar v1
  # waybar_config = import ./og/config.nix {inherit osConfig config lib pkgs;};
  # waybar_style = import ./og/style.nix {inherit (config) colorscheme;};
  # NixBar
  waybar_config = import ./nixbar/config.nix { inherit osConfig config lib pkgs; };
  waybar_style = import ./nixbar/style.nix { inherit (config) colorscheme; };
  # Tokyonight
  # waybar_config = import ./tokyonight/config.nix {inherit osConfig config lib pkgs;};
  # waybar_style = import ./tokyonight/style.nix {inherit (config) colorscheme;};
  # Catppuccin
  # waybar_config = import ./catppuccin/config.nix { inherit osConfig config lib pkgs; };
  # waybar_style = import ./catppuccin/style.nix { inherit (config) colorscheme; };
  # New bar
  # waybar_config = import ./default/config.nix { inherit osConfig config lib pkgs; };
  # waybar_style = import ./default/style.nix { inherit (config) colorscheme; };
in
{
  options.desktop.addons.waybar = with types; {
    enable = mkBoolOpt false "Enable or disable waybar";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = waybar_config;
      style = waybar_style;
    };
    home.extraOptions.xdg = {
      configFile = {
        "waybar/machiatto.css".text = ''
          /*
          *
          * Catppuccin Macchiato palette
          * Maintainer: rubyowo
          *
          */

          @define-color base   #24273a;
          @define-color mantle #1e2030;
          @define-color crust  #181926;

          @define-color text     #cad3f5;
          @define-color subtext0 #a5adcb;
          @define-color subtext1 #b8c0e0;

          @define-color surface0 #363a4f;
          @define-color surface1 #494d64;
          @define-color surface2 #5b6078;

          @define-color overlay0 #6e738d;
          @define-color overlay1 #8087a2;
          @define-color overlay2 #939ab7;

          @define-color blue      #8aadf4;
          @define-color lavender  #b7bdf8;
          @define-color sapphire  #7dc4e4;
          @define-color sky       #91d7e3;
          @define-color teal      #8bd5ca;
          @define-color green     #a6da95;
          @define-color yellow    #eed49f;
          @define-color peach     #f5a97f;
          @define-color maroon    #ee99a0;
          @define-color red       #ed8796;
          @define-color mauve     #c6a0f6;
          @define-color pink      #f5bde6;
          @define-color flamingo  #f0c6c6;
          @define-color rosewater #f4dbd6;
        '';
      };
    };
  };
}
