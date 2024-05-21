{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    statix
    alejandra
    nurl
    nix-init
    nix-prefetch-git
  ];
}
