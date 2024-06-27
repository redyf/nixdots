{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    statix
    alejandra
    nix-init
  ];
}
