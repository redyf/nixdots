{pkgs, ...}: {
  home.packages = with pkgs; [
    # Nix Packages
    alejandra # Nix formatter written in Rust
    statix # Lints and suggestions for the nix programming language
    nil # Nix LSP

    # Nix utils
    nix-init # Command line tool to generate Nix packages from URLs
    nix-prefetch-git # Script used to obtain source hashes for fetchgit
  ];
}
