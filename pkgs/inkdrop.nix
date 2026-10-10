{
  lib,
  stdenv,
  stdenvNoCC,
  fetchurl,
  dpkg,
  unzip,
  autoPatchelfHook,
  coreutils,
  makeWrapper,
  wrapGAppsHook3,
  alsa-lib,
  at-spi2-atk,
  cups,
  gtk3,
  libdrm,
  libgbm,
  libGL,
  libnotify,
  libsecret,
  libxkbfile,
  nspr,
  nss,
  systemd,
  libx11,
  libxcb,
  libxcomposite,
  libxdamage,
  libxext,
  libxfixes,
  libxrandr,
  libxshmfence,
}:
let
  pname = "inkdrop";
  version = "5.11.10";

  sources = {
    x86_64-linux = fetchurl {
      url = "https://dev.inkdrop.app/dist/v${version}/inkdrop_${version}_amd64.deb";
      hash = "sha256-AgX/v4IOMDYO1wWWS7FZBkU7B1hCdVzQjz3IZqSH554=";
    };
    x86_64-darwin = fetchurl {
      url = "https://dev.inkdrop.app/dist/v${version}/Inkdrop-${version}-x64-Mac.zip";
      hash = "sha256-dL53lP+qHxWJXYXOt55inI4tBP+F0H5BTDr8W56YLzU=";
    };
    aarch64-darwin = fetchurl {
      url = "https://dev.inkdrop.app/dist/v${version}/Inkdrop-${version}-arm64-Mac.zip";
      hash = "sha256-ghqztQjenpPudttmEv9SoQLcpR9LRuCrlKyWChrgQTY=";
    };
  };

  src =
    sources.${stdenv.hostPlatform.system}
      or (throw "inkdrop: unsupported system ${stdenv.hostPlatform.system}");

  meta = {
    description = "Markdown note-taking app";
    homepage = "https://www.inkdrop.app/";
    changelog = "https://docs.inkdrop.app/reference/release-notes";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    maintainers = with lib.maintainers; [ redyf ];
    mainProgram = "inkdrop";
    platforms = lib.attrNames sources;
  };
in
if stdenv.hostPlatform.isDarwin then
  stdenvNoCC.mkDerivation {
    inherit
      pname
      version
      src
      meta
      ;

    nativeBuildInputs = [
      unzip
      makeWrapper
    ];

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall

      mkdir -p $out/Applications
      cp -r Inkdrop.app $out/Applications/
      makeWrapper $out/Applications/Inkdrop.app/Contents/MacOS/Inkdrop $out/bin/inkdrop

      runHook postInstall
    '';

    # Keep the upstream code signature intact.
    dontFixup = true;
  }
else
  stdenv.mkDerivation {
    inherit
      pname
      version
      src
      meta
      ;

    nativeBuildInputs = [
      dpkg
      autoPatchelfHook
      makeWrapper
      wrapGAppsHook3
    ];

    buildInputs = [
      alsa-lib
      at-spi2-atk
      cups
      gtk3
      libdrm
      libgbm
      libsecret
      libxkbfile
      nspr
      nss
      libx11
      libxcomposite
      libxdamage
      libxext
      libxfixes
      libxrandr
      libxcb
      libxshmfence
    ];

    dontWrapGApps = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib
      cp -r usr/lib/inkdrop $out/lib/inkdrop
      cp -r usr/share $out/share

      # Drop prebuilt leveldown binaries for other platforms; autoPatchelf can't handle them.
      prebuilds=$out/lib/inkdrop/resources/app.asar.unpacked/node_modules/leveldown/prebuilds
      find $prebuilds -mindepth 1 -maxdepth 1 ! -name linux-x64 -exec rm -r {} +
      rm $prebuilds/linux-x64/node.napi.musl.node

      install -Dm444 usr/share/pixmaps/inkdrop.png $out/share/icons/hicolor/256x256/apps/inkdrop.png

      # Inkdrop spawns ipm with an env that has no PATH; give its launcher coreutils.
      substituteInPlace $out/lib/inkdrop/resources/app/ipm/bin/ipm \
        --replace-fail "set -e" "set -e
      export PATH=${lib.makeBinPath [ coreutils ]}\''${PATH:+:\$PATH}"

      runHook postInstall
    '';

    postFixup = ''
      makeWrapper $out/lib/inkdrop/inkdrop $out/bin/inkdrop \
        "''${gappsWrapperArgs[@]}" \
        --prefix LD_LIBRARY_PATH : ${
          # Loaded with dlopen by Electron/ANGLE at runtime.
          lib.makeLibraryPath [
            (lib.getLib systemd)
            libGL
            libnotify
          ]
        } \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}"
    '';
  }
