{
  stdenv,
  fetchurl,
  xorg,
  patchelf,
  makeWrapper,
  ...
}:
# Stolen from https://github.com/HanStolpo/nixos-config-public/blob/master/overlays/realvnc-viewer/realvnc-viewer.nix
stdenv.mkDerivation {
  name = "realvnc-viewer";
  src =
    if stdenv.isAarch64
    then
      fetchurl
      {
        url = "https://downloads.realvnc.com/download/file/viewer.files/VNC-Viewer-7.12.0-Linux-ARM64";
        sha256 = "sha256-r/eDIwIrAO/0vyGE/zloJG/sA7tqotJQCkXtpnoO1WE=";
      }
    else
      stdenv.stdenv.isx86_64 {
        url = "https://downloads.realvnc.com/download/file/viewer.files/VNC-Viewer-7.12.0-Linux-x64";
        sha256 = "sha256-mFWdM6kYO0LZxF0vsEn4LRBj2hgzgvUqiWDEzMfwBzE=";
      };
  dontUnpack = true;
  buildInputs = [xorg.libX11 xorg.libXext xorg.libSM xorg.libICE patchelf makeWrapper];
  buildPhase = ''
    export INTERPRETER=$(cat $NIX_CC/nix-support/dynamic-linker)
    echo "INTERPRETER=$INTERPRETER"
    cp $src realvnc-viewer
    chmod +wx realvnc-viewer
    echo "patching interpreter"
    patchelf --set-interpreter \
      "$INTERPRETER" \
      realvnc-viewer
  '';
  installPhase = ''
    echo "making output directory"
    mkdir -p $out/bin
    echo "copying to output"
    cp realvnc-viewer $out/bin
    echo "wrapping program"
    wrapProgram $out/bin/realvnc-viewer \
      --set LD_LIBRARY_PATH "${xorg.libX11}/lib:${xorg.libXext}/lib:${xorg.libSM}/lib:${xorg.libICE}/lib"
  '';
}
