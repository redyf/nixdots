{pkgs, ...}: {
  home.packages = with pkgs; [
    nix-ld
  ];
}
