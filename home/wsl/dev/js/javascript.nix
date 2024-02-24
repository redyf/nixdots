{pkgs, ...}: {
  home.packages = with pkgs; [
    # NPM packages
    bun
    yarn
    nodejs
    # node2nix
    typescript
    tailwindcss
    nodePackages.npm # Package manager
    nodePackages_latest.pnpm
    nodePackages_latest.ts-node
    nodePackages_latest.prisma
    nodePackages_latest.dotenv-cli
    # nodePackages_latest.eslint_d # JS linter
    # nodePackages_latest.prettier # Formatter
    # nodePackages_latest.typescript-language-server # lsp
    # nodePackages_latest.tailwindcss
    # nodePackages_latest.live-server # Live server
  ];
}
