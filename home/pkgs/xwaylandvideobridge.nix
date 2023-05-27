{
  lib,
  stdenv,
  fetchFromGitLab,
  cmake,
}:
stdenv.mkDerivation rec {
  pname = "xwaylandvideobridge";
  version = "unstable-2023-05-23";

  src = fetchFromGitLab {
    domain = "invent.kde.org";
    owner = "system";
    repo = "xwaylandvideobridge";
    rev = "ca68fa980f5ead2c2c10d97b7af3cfaef53afa63";
    hash = "sha256-G86gGyIy806iCtdItmpXG+5qNaYFP8oChk2p/dHQVlU=";
  };

  nativeBuildInputs = [
    cmake
  ];

  meta = with lib; {
    description = "Utility to allow streaming Wayland windows to X applications";
    homepage = "https://invent.kde.org/system/xwaylandvideobridge";
    license = with licenses; [];
    maintainers = with maintainers; [];
  };
}
