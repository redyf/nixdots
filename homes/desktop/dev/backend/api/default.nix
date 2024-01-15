{ pkgs, ... }: {
  home.packages = with pkgs; [
    httpie
    openssl
    # postman
  ];
}
