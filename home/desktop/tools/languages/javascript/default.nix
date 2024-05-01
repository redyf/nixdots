{pkgs, ...}: {
  home.packages = with pkgs; [
    bun
    deno
    nodejs
    typescript
    nodePackages.npm
  ];
}
