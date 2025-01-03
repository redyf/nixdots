{
  pkgs,
  fetchurl,
  appimageTools,
  lib,
  ...
}:
let
  pname = "hydra";
  version = "3.0.5";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/hydralauncher/hydra/releases/download/v${version}/hydralauncher-${version}.AppImage";
    sha256 = "sha256-KATrn9fqXzMftVwafA3wCWbBqldZbT6loc0EfvnvnPg=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname src; };
in
appimageTools.wrapType2 {
  inherit pname src;

  extraInstallCommands = ''
    mv $out/bin/${pname} $out/bin/${pname}

    # Install .desktop file
    install -Dm644 ${appimageContents}/hydralauncher.desktop $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'

    # Install icon
    if [ -f ${appimageContents}/hydralauncher.png ]; then
      install -Dm644 ${appimageContents}/hydralauncher.png \
        $out/share/icons/hicolor/512x512/apps/${pname}.png
    fi
  '';

  meta = {
    description = "Hydra is a game launcher with its own embedded bittorrent client";
    homepage = "https://github.com/hydralauncher/hydra";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    license = lib.licenses.mit;
    mainProgram = pname;
  };
}
