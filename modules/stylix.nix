{ inputs, pkgs, ... }:
let
  themes = {
    catppuccin-mocha = "catppuccin-mocha";
    mountain = "mountain";
    oxocarbon-dark = "oxocarbon-dark";
    jabuti = {
      scheme = "Jabuti";
      author = "Notusknot";
      base00 = "292a37";
      base01 = "343545";
      base02 = "3c3e51";
      base03 = "45475d";
      base04 = "50526b";
      base05 = "c0cbe3";
      base06 = "d9e0ee";
      base07 = "ffffff";
      base08 = "ec6a88";
      base09 = "efb993";
      base0A = "e1c697";
      base0B = "3fdaa4";
      base0C = "ff7eb6";
      base0D = "3fc6de";
      base0E = "be95ff";
      base0F = "8b8da9";
    };
  };
in
{
  stylix = {
    enable = true;
    autoEnable = true;
    image = ../hosts/redyf/9ovcXG0Wo4P7FQPe.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${themes.mountain}.yaml";
    # base16Scheme = themes.jabuti;
    fonts = {
      monospace = {
        package = inputs.font-flake.packages.${pkgs.system}.berkeley;
        name = "Liga Berkeley Mono";
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
      gtk.enable = true;
      nixos-icons.enable = true;
    };
  };
}
