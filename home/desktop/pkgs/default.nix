let
  pkgs = import <nixpkgs> {};
in {
  nvchad = pkgs.callPackage ./nvchad.nix {};
  httpie-desktop = pkgs.callPackage ./httpie-desktop.nix {};
}
