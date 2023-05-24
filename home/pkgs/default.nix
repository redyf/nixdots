{
  inputs,
  pkgs,
  ...
}: let
  callPackage = pkgs.lib.callPackageWith pkgs;
in
  with pkgs; {
    # xwaylandvideobridge = callPackage ./xwaylandvideobridge.nix {};
    sf-mono-liga-src = callPackage ./sf-mono-liga.nix {};
  }
