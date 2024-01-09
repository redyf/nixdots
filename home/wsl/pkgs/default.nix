let
  pkgs = import <nixpkgs> { };
in
{
  nvchad = pkgs.callPackage ./nvchad.nix { };
}
