final: prev: {
  fastfetch = prev.callPackage ./fastfetch { };
  # firefox-overlay = prev.callPackage ./firefox-overlay.nix { };
  sf-mono-liga-bin = prev.callPackage ./sf-mono-liga-bin.nix { };
  xwaylandvideobridge = prev.callPackage ./xwaylandvideobridge.nix { };
}
