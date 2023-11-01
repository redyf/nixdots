{
  appimageTools,
  fetchurl,
}:
appimageTools.wrapType2 {
  name = "httpie";
  src = fetchurl {
    url = "https://github.com/httpie/desktop/releases/download/v2023.3.6/HTTPie-2023.3.6.AppImage";
    hash = "01zs7z9a9794mnmfapv6w2hgk5q366jan11x2bdzgrbwkf0778r2";
  };
  extraPkgs = pkgs: with pkgs; [];
}
