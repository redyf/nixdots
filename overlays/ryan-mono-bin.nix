(_: prev: let
  version = "2023.07.25";

  mkFontVariant = {
    variant,
    sha256,
  }:
    prev.callPackage ({
      lib,
      fetchzip,
    }:
      fetchzip rec {
        pname = variant;
        inherit version;

        url = "https://github.com/ryanccn/ryan-mono/releases/download/${version}/${variant}.zip";
        stripRoot = false;

        postFetch = ''
          postDir="$TMPDIR/post"
          mkdir -p $postDir
          mv $out/* $postDir
          mkdir -p $out/share/fonts/truetype
          mv $postDir/*.ttf $out/share/fonts/truetype
        '';

        inherit sha256;

        meta = with lib; {
          homepage = "https://github.com/ryanccn/ryan-mono";
          description = "Iosevka with customizations and Nerd Font patches";
          platforms = platforms.all;
        };
      }) {};
in {
  ryan-mono-bin = mkFontVariant {
    variant = "ryan-mono";
    sha256 = "sha256-u8Ex7PgPxQVQt4VSQMsvpcO2g3Ma/75NAxIn3tATf5w=";
  };

  ryan-term-bin = mkFontVariant {
    variant = "ryan-term";
    sha256 = "sha256-VmgmZFIPD7mLl1ATR1nlQN+qzFHXkopj8XZg97VgtlU=";
  };
})
