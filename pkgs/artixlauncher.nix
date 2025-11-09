{
  lib,
  fetchurl,
  imagemagick,
  makeWrapper,
  appimageTools,
  makeDesktopItem,
}:

let
  pname = "artix-games-launcher";
  version = "2.20";

  src = fetchurl {
    url = "https://launch.artix.com/latest/Artix_Games_Launcher-x86_64.AppImage";
    hash = "sha256-8eVXOm5g92wErWa6lbTXrCL04MWYlObjonHJk+oUI3E=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

  desktopFile = makeDesktopItem {
    name = "artix-games-launcher";
    exec = "artix-games-launcher %U";
    icon = "artix-games-launcher";
    desktopName = "Artix Games Launcher";
    comment = "One app. All your favorite Artix games.";
    categories = [ "Game" ];
    startupNotify = true;
    terminal = false;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  nativeBuildInputs = [
    makeWrapper
    imagemagick
  ];

  extraInstallCommands = ''
    install -Dm644 ${desktopFile}/share/applications/artix-games-launcher.desktop \
      $out/share/applications/artix-games-launcher.desktop

    wrapProgram $out/bin/artix-games-launcher \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --use-gl=desktop}}"

    ${lib.getExe imagemagick} ${appimageContents}/ArtixLogo.png -resize 512x512 ArtixLogo_512.png
    install -m 444 -D ArtixLogo_512.png \
      $out/share/icons/hicolor/512x512/apps/artix-games-launcher.png

    mkdir -p $out/share/pixmaps
    ln -s $out/share/icons/hicolor/512x512/apps/artix-games-launcher.png \
      $out/share/pixmaps/artix-games-launcher.png
  '';

  meta = {
    description = "One app. All your favorite Artix games.";
    homepage = "https://www.artix.com/";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    license = lib.licenses.unfree;
    mainProgram = "artix-games-launcher";
  };
}
