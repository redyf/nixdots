{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    statix
    alejandra
    nix-init
    nix-update
    nixpkgs-review
  ];
}
