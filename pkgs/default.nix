{ pkgs }:
with pkgs; {
  sfmono-nf = callPackage ./sfmono-nf.nix { };
  xwaylandvideobridge = callPackage ./xwaylandvideobridge.nix { };
}
