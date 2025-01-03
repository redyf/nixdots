{
  pkgs,
  makeWrapper,
  lib,
  ...
}:
let
  pname = "insomnia";
  version = "8.6.1";
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://github.com/Kong/insomnia/releases/download/core%40${version}/Insomnia.Core-${version}.AppImage";
    sha256 = "sha256-3ofrn+/w7dnvXnBrXBcPB+j8hvOJG5kR3UNZp+Gm5O0=";
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
in
pkgs.appimageTools.wrapType2 rec {
  inherit name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    source "${makeWrapper}/nix-support/setup-hook"

    wrapProgram $out/bin/${pname} \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --use-gl=desktop}}"

    install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop

    ${pkgs.imagemagick}/bin/convert ${appimageContents}/${pname}.png -resize 512x512 ${pname}_512.png

    install -m 444 -D ${pname}_512.png $out/share/icons/hicolor/512x512/apps/${pname}.png

    substituteInPlace $out/share/applications/${pname}.desktop \
    	--replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} %U'
  '';

  meta = with lib; {
    homepage = "https://insomnia.rest/";
    description = "The most intuitive cross-platform REST API Client";
    platforms = [ "x86_64-linux" ];
  };
}
