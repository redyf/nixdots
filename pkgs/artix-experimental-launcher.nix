{
  lib,
  fetchzip,
  appimageTools,
  glib-networking,
}:

let
  pname = "artix-experimental-launcher";
  version = "1.7.0";

  # The download is a zip holding a single AppImage.
  zip = fetchzip {
    url = "https://chaoslabs.artix.com/Ruffle/${version}/ArtixGamesLauncher-Ruffle-${version}-linux-x64.zip";
    hash = "sha256-IEYzsWDVAXhluvYc0/g2taMurM1MHIl907eAxzt+FR4=";
    stripRoot = false;
  };

  src = "${zip}/ArtixGamesLauncher.AppImage";

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  # Tauri (WebKitGTK) frontend; ruffle_desktop's libs are already in the default FHS env.
  extraPkgs = pkgs: [
    pkgs.webkitgtk_4_1
    pkgs.libsoup_3
  ];

  # Nixpkgs' GLib doesn't search /usr/lib/gio/modules, so point it at the TLS backend
  # (without it WebKit fails with "TLS support is not available").
  profile = ''
    export GIO_EXTRA_MODULES="${glib-networking}/lib/gio/modules''${GIO_EXTRA_MODULES:+:$GIO_EXTRA_MODULES}"
  '';

  extraInstallCommands = ''
    install -Dm644 ${appimageContents}/com.artix.GamesLauncher.desktop \
      $out/share/applications/com.artix.GamesLauncher.desktop
    substituteInPlace $out/share/applications/com.artix.GamesLauncher.desktop \
      --replace-fail 'Exec=artix-games-launcher' 'Exec=${pname}'

    install -Dm644 ${appimageContents}/usr/share/icons/hicolor/256x256/apps/com.artix.GamesLauncher.png \
      $out/share/icons/hicolor/256x256/apps/com.artix.GamesLauncher.png
  '';

  meta = {
    description = "Experimental Artix Games Launcher that plays Flash games with Ruffle";
    homepage = "https://www.artix.com/experiments/ArtixExperimentalLauncher";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    license = lib.licenses.unfree;
    mainProgram = pname;
  };
}
