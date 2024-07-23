{
  inputs,
  pkgs,
  ...
}: let
  themes = {
    oxocarbon-dark = "oxocarbon-dark";
    paradiseTheme = builtins.fromJSON (builtins.readFile ./paradise.json);
  };
in {
  stylix = {
    enable = true;
    autoEnable = true;
    image = ../hosts/redyf/9ovcXG0Wo4P7FQPe.jpg;
    # base16Scheme = themes.paradiseTheme;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${themes.oxocarbon-dark}.yaml";
    fonts = {
      monospace = {
        package = with pkgs; inputs.font-flake.packages.${system}.berkeley;
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
        applications = 10;
        terminal = 11;
        desktop = 10;
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
