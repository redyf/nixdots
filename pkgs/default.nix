{ pkgs, ... }: {
  # My personal derivations for packages that are not on nixpkgs
  fastfetch = pkgs.callPackage ./overlays/fastfetch { };
}
