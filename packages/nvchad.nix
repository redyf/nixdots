{ lib
, stdenvNoCC
, fetchFromGitHub
, ...
}:
stdenvNoCC.mkDerivation rec {
  name = "nvchad";
  version = "2.0";

  src = fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "refs/heads/v${version}";
    sha256 = "3gH3VIXKeWDlFowfsxffRcjOa7Yjoy+COfX0sVNDc24=";
  };

  preferLocalBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r ./ $out
  '';

  meta = with lib; {
    description = "NvChad";
    homepage = "https://github.com/NvChad/NvChad";
    platforms = platforms.all;
    license = licenses.gpl3;
  };
}
