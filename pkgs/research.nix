{
  lib,
  fetchurl,
  appimageTools,
  imagemagick,
}:

let
  pname = "research";
  version = "0.8.7";

  src = fetchurl {
    url = "https://un.ms/research/downloads/${version}/Research_${version}_amd64.AppImage";
    hash = "sha256-KsbUhTvJRhBka3u1vSp+XW312OQOZ/3wsqYkn9APgB4=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
        # Install desktop file
        if [ -f "${appimageContents}/research.desktop" ]; then
          install -m 444 -D "${appimageContents}/research.desktop" "$out/share/applications/research.desktop"
          substituteInPlace "$out/share/applications/research.desktop" \
            --replace 'Exec=Research' 'Exec=research'
        else
          mkdir -p "$out/share/applications"
          cat > "$out/share/applications/research.desktop" << 'EOF'
    [Desktop Entry]
    Type=Application
    Name=Research
    Exec=research
    Icon=research
    Categories=Development;Utility;
    EOF
        fi

        # Install icon
        if [ -f "${appimageContents}/research.png" ]; then
          install -m 444 -D "${appimageContents}/research.png" "$out/share/icons/hicolor/512x512/apps/research.png"
        else
          # Generate fallback icon
          mkdir -p "$out/share/icons/hicolor/512x512/apps/"
          ${imagemagick}/bin/convert -size 512x512 xc:white \
            -gravity center -fill black -pointsize 72 \
            -annotate +0+0 "Research" \
            "$out/share/icons/hicolor/512x512/apps/research.png"
        fi
  '';

  meta = with lib; {
    description = "Platform for building, testing, and documenting APIs";
    homepage = "https://research.com/";
    license = licenses.unfree;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "research";
  };
}
