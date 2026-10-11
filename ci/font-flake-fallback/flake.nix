{
  description = "CI fallback for private font-flake packages";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          # Public stand-ins for every package the private font-flake exposes.
          tx02 = pkgs.nerd-fonts.jetbrains-mono;
          monolisa = pkgs.nerd-fonts.jetbrains-mono;
          berkeley-mono = pkgs.nerd-fonts.jetbrains-mono;
          sf-mono = pkgs.nerd-fonts.jetbrains-mono;
        }
      );
    };
}
