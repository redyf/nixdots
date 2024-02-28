{
  pkgs,
  makeWrapper,
  lib,
  ...
}: let
  pname = "ArtixGamesLauncher";
  version = "2.1.2";
  name = "${pname}-${version}";
  logo = "ArtixLogo";

  src = pkgs.fetchurl {
    url = "https://launch.artix.com/latest/Artix_Games_Launcher-x86_64.AppImage";
    sha256 = "0qa5rrrmvxgy90lbpxjxsyf22wj1l5im0p4idizkdwb1cwc3rnjk";
  };

  appimageContents = pkgs.appimageTools.extractType2 {inherit name src;};
in
  pkgs.appimageTools.wrapType2 rec {
    inherit name src;

    extraInstallCommands = ''
      mv $out/bin/${name} $out/bin/${pname}
      source "${makeWrapper}/nix-support/setup-hook"

      wrapProgram $out/bin/${pname} \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"

      install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop

      # Directly use ArtixLogo.png without conversion
      install -m  444 -D ${appimageContents}/${logo}.png $out/share/icons/hicolor/512x512/apps/${pname}.png

      substituteInPlace $out/share/applications/${pname}.desktop \
      	--replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} %U'
    '';

    meta = with lib; {
      homepage = "https://www.artix.com/";
      description = "One app. All your favorite Artix games.";
      platforms = ["x86_64-linux"];
    };
  }
