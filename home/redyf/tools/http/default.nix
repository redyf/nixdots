{pkgs, ...}: {
  home.packages = with pkgs; [wget curl httpie openssl];
}
