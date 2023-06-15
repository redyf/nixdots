{pkgs, ...}: {
  home.packages = with pkgs; [
    # NPM packages
    nodejs
    node2nix
    nodePackages.npm # Package manager
    nodePackages_latest.live-server # Live server
    nodePackages_latest.eslint_d # JS linter
    nodePackages_latest.prettier # Formatter
    nodePackages_latest.tailwindcss
  ];
}
