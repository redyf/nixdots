{pkgs, ...}: {
  home.packages = with pkgs; [curl httpie openssl];
}
