{inputs, ...}: let
  inherit (inputs.nix-colors) colorSchemes;
  # catppuccin-mocha = (import ./palettes/catppuccin-mocha.nix).colorscheme;
  catppuccin-macchiato = (import ./palettes/catppuccin-macchiato.nix).colorscheme;
  # oxocarbon-dark = (import ./palettes/oxocarbon-dark.nix).colorscheme;
in {
  imports = [
    inputs.nix-colors.homeManagerModule
    ./gtk.nix
  ];
  # Use the colorscheme available at github:tinted-theming/base16-schemes
  #colorscheme = colorSchemes.ashes;

  # use the self-declared color scheme from palettes directory
  # colorscheme = catppuccin-mocha;
  colorscheme = catppuccin-macchiato;
  # colorscheme = oxocarbon-dark;
}
