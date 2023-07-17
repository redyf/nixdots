{
  description = "A flake giving access to fonts that I use, outside of nixpkgs.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      defaultPackage = pkgs.symlinkJoin {
        name = "myfonts-0.1.4";
        paths =
          builtins.attrValues
          self.packages.${system}; # Add font derivation names here
      };

      packages.times = pkgs.stdenvNoCC.mkDerivation {
        name = "times-font";
        dontConfigue = true;
        src = pkgs.fetchzip {
          url = "https://www.freebestfonts.com/download?fn=1911";
          sha256 = "0000000000000000000000000000000000000000000000000000";
          stripRoot = false;
        };
        installPhase = ''
          mkdir -p $out/share/fonts
          cp -R $src $out/share/fonts/opentype/
        '';
        meta = {description = "A Gill Sans Font Family derivation.";};
      };
    });
}
