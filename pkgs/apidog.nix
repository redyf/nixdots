{
  pkgs,
  fetchzip,
  appimageTools,
  makeWrapper,
  imagemagick,
  lib,
  ...
}:
let
  pname = "apidog";
  version = "2.6.30";

  zipFile = fetchzip {
    url = "https://web.archive.org/web/20241114142057if_/https://file-assets.apidog.com/download/Apidog-linux-latest.zip";
    sha256 = "sha256-tkGL4+Ol/9H92vemJIe5riyg+l6mGHWK5q5Mz6gK5no=";
    stripRoot = false;
  };

  # Extract AppImage to a new derivation
  src = pkgs.runCommand "apidog-appimage" { } ''
    cp ${zipFile}/Apidog.AppImage $out
    chmod +x $out
  '';

  appimageContents = pkgs.appimageTools.extractType2 {
    inherit
      src
      pname
      version
      ;
  };
in
appimageTools.wrapType2 rec {
  inherit
    src
    pname
    version
    ;

  extraInstallCommands = ''
    source "${makeWrapper}/nix-support/setup-hook"
    wrapProgram $out/bin/apidog \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --use-gl=desktop}}"

    # Install desktop file
    if [ -f ${appimageContents}/apidog.desktop ]; then
      install -m 444 -D ${appimageContents}/apidog.desktop $out/share/applications/apidog.desktop
      substituteInPlace $out/share/applications/apidog.desktop \
        --replace 'Exec=Apidog' 'Exec=apidog'
    else
      echo "[Desktop Entry]
      Type=Application
      Name=Apidog
      Exec=apidog
      Icon=apidog
      Categories=Development;Utility;
      " > $out/share/applications/apidog.desktop
    fi

    # Install icon, generate a custom fallback if needed
    if [ -f ${appimageContents}/apidog.png ]; then
      ${imagemagick}/bin/magick ${appimageContents}/apidog.png -resize 512x512 apidog_512.png
      install -m 444 -D apidog_512.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    else
      echo "Generating fallback icon..."
      mkdir -p $out/share/icons/hicolor/512x512/apps/
      ${imagemagick}/bin/convert -size 512x512 xc:white \
        -gravity center -fill black -pointsize 72 \
        -annotate +0+0 "Apidog" \
        $out/share/icons/hicolor/512x512/apps/apidog.png
    fi
  '';

  meta = {
    description = "Platform for building, testing, and documenting APIs";
    homepage = "https://apidog.com/";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    license = lib.licenses.unfree;
    mainProgram = "apidog";
  };
}
