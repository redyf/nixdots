{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.themes.stylix;
  themes = {
    catppuccin-mocha = "catppuccin-mocha";
    oxocarbon-dark = "oxocarbon-dark";
    tokyo-night-moon = "tokyo-night-moon";
    tokyo-night-dark = "tokyo-night-dark";
    tokyo-night-storm = "tokyo-night-storm";
  };
in
{
  config = lib.mkIf (config.myConfig.themes.enable && cfg.enable) {
    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${themes.catppuccin-mocha}.yaml";
      cursor = {
        name = "macOS";
        package = pkgs.apple-cursor;
        size = 36;
      };
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
        sizes = {
          applications = 11;
          terminal = 12;
          desktop = 11;
          popups = 11;
        };
      };
      opacity = {
        applications = 1.0;
        terminal = 0.95;
        desktop = 1.0;
        popups = 1.0;
      };
      polarity = "dark";
      targets = {
        grub.enable = false;
        gnome.enable = false;
        gtk.enable = false;
        nixos-icons.enable = true;
        qt.enable = true;
      };
    };
  };
}
