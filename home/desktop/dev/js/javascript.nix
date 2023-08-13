{pkgs, ...}: {
  home.packages = with pkgs; [
    # NPM packages
    nodejs
    node2nix
    yarn
    typescript
    tailwindcss
    nodePackages.npm # Package manager
    nodePackages_latest.eslint_d # JS linter
    nodePackages_latest.prettier # Formatter
    # nodePackages_latest.tailwindcss
    # nodePackages_latest.live-server # Live server
    nodePackages_latest.typescript-language-server # lsp
  ];
}
