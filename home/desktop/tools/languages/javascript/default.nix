{pkgs, ...}: {
  home.packages = with pkgs; [
    # NPM packages
    bun
    nodejs
    typescript
    nodePackages.npm # Package manager
  ];
}
