{
  inputs,
  config,
  lib,
  pkgs,
  theme,
  ...
}:

let
  cfg = config.myConfig.themes.stylix;
in
{
  options.myConfig.themes.stylix.enable = lib.mkEnableOption "stylix";

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme.scheme}.yaml";
      cursor = {
        inherit (theme.cursor) name size;
        package = pkgs.apple-cursor;
      };
      fonts = {
        monospace = {
          package = inputs.font-flake.packages.${pkgs.stdenv.hostPlatform.system}.tx02;
          name = "TX-02";
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
          terminal = theme.terminalFontSize;
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
      inherit (theme) polarity;
      targets = {
        grub.enable = false;
        gnome.enable = false;
        gtk.enable = true;
        nixos-icons.enable = true;
        qt.enable = true;
      };
    };
  };
}
