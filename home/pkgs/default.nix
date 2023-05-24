self: (
  super: {
    ly = super.callPackage ../pkgs/ly {};
    sf-mono-liga-src = super.callPackage ./sf-mono-liga.nix {};
    xwaylandvideobridge = super.callPackage ./xwaylandvideobridge.nix {};
  }
)
