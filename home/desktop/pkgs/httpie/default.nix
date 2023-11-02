{
  pkgs,
  lib,
  ...
}: let
  pname = "HTTPie";
  version = "v2023.3.6";
  name = "${pname}-${version}";

  src = pkgs.fetchurl {
    url = "https://github.com/httpie/desktop/releases/download/v2023.3.6/HTTPie-2023.3.6.AppImage";
    sha256 = "sha256-IqNzgJt85ffbEj0Eq6QxA5f5oOBmX+WqrSSdpNI/+gc=";
  };

  appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
in
  pkgs.appimageTools.wrapType2 rec {
    inherit name src;

    extraInstallCommands = ''
      mv $out/bin/${name} $out/bin/${pname}
      install -m 444 -D ${appimageContents}/HTTPie.desktop $out/share/applications/${pname}.desktop

      install -m 444 -D ${appimageContents}/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png

      substituteInPlace $out/share/applications/${pname}.desktop \
      	--replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} %U'
    '';

    meta = with lib; {
      description = "🚀 HTTPie Desktop — cross-platform API testing client for humans. Painlessly test REST, GraphQL, and HTTP APIs.";
      homepage = "https://httpie.io/";
      license = licenses.gpl3;
      maintainers = [];
      platforms = ["x86_64-linux"];
    };
  }
