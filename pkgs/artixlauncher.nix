{
  lib,
  fetchurl,
  imagemagick,
  makeWrapper,
  appimageTools,
  ...
}:
let
  pname = "artix-games-launcher";
  version = "2.1.2";

  src = fetchurl {
    url = "https://launch.artix.com/latest/Artix_Games_Launcher-x86_64.AppImage";
    hash = "sha256-8eVXOm5g92wErWa6lbTXrCL04MWYlObjonHJk+oUI3E=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit
      pname
      version
      src
      ;
  };
in
appimageTools.wrapType2 {
  inherit
    pname
    version
    src
    ;
  extraInstallCommands = ''
    source "${makeWrapper}/nix-support/setup-hook"

    wrapProgram $out/bin/artix-games-launcher \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --use-gl=desktop}}"

    # Check for required desktop file
    if [ ! -f ${appimageContents}/ArtixGamesLauncher.desktop ]; then
      echo "Error: Missing .desktop file in ${appimageContents}"
      exit 1
    else
      # Install and modify the desktop file
      install -m 444 -D ${appimageContents}/ArtixGamesLauncher.desktop $out/share/applications/ArtixGamesLauncher.desktop
      substituteInPlace $out/share/applications/ArtixGamesLauncher.desktop \
        --replace 'Exec=AppRun --no-sandbox %U' 'Exec=artix-games-launcher %U'
    fi

    # Check for required icon file
    if [ ! -f ${appimageContents}/ArtixLogo.png ]; then
      echo "Error: Missing icon file in ${appimageContents}"
      exit 1
    else
      # Resize and install the icon
      ${lib.getExe imagemagick} ${appimageContents}/ArtixLogo.png -resize 512x512 ArtixLogo_512.png
      install -m 444 -D ArtixLogo_512.png $out/share/icons/hicolor/512x512/apps/ArtixLogo.png
    fi
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
