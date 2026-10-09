{
  inputs,
  nixpkgs,
  overlays ? [ ],
}:
let
  inherit (nixpkgs) lib;

  # Systems for per-system outputs (devShells, formatter, checks). Hosts pick
  # their own `system` in meta.nix; add an entry here when a host needs it.
  systems = [ "x86_64-linux" ];

  mkHost = import ./mkHost.nix { inherit inputs nixpkgs overlays; };
  mkHome = import ./mkHome.nix { inherit inputs nixpkgs overlays; };
  discover = import ./discover.nix { inherit lib; };
  checks = import ./checks.nix { inherit lib; };
in
{
  inherit systems mkHost mkHome;
  forAllSystems = lib.genAttrs systems;
  inherit (discover) discoverHosts discoverHomes;
  inherit (checks) mkHomeEvalCheck;
}
