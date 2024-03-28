{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    statix
    alejandra
    nix-index
    nix-init
    nix-prefetch-git
  ];
}
