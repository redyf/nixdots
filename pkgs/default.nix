{ pkgs, ... }:
with pkgs; {
  xwaylandvideobridge = callPackage ./xwaylandvideobridge.nix { };
}
