{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    bun
    nodejs
    typescript
    nodePackages.npm # Package manager
    nodePackages_latest.pnpm
    nodePackages_latest.ts-node
    nodePackages_latest.dotenv-cli
  ];
  shellHook = ''
    echo "Environment is ready" | ${pkgs.lolcat}/bin/lolcat;
  '';
}
