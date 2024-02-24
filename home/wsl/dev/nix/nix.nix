{pkgs, ...}: {
  home.packages = with pkgs; [
    # Nix Packages
    nil # Nix LSP
    statix # Lints and suggestions for the nix programming language
    alejandra # Nix formatter written in Rust
    # Nix utils
    nix-init # Command line tool to generate Nix packages from URLs
    nix-prefetch-git # Script used to obtain source hashes for fetchgit
  ];
}
