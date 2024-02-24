{
  inputs,
  pkgs,
  ...
}: let
  manixFlake = inputs.manix.packages.${pkgs.system}.manix;
in {
  home.packages = with pkgs; [
    nil
    statix
    alejandra
    nix-index
    nix-init
    nix-prefetch-git
    manixFlake
  ];
}
