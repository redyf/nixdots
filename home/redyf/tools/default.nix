{lib, ...}: {
  imports = [
    ./git
    ./http
    ./direnv
    ./languages
  ];

  git.enable = lib.mkDefault true;
  http.enable = lib.mkDefault true;
  direnv.enable = lib.mkDefault true;
  languages.enable = lib.mkDefault true;
}
