{
  inputs,
  nixpkgs,
  overlays ? [ ],
}:
let
  inherit (nixpkgs) lib;

  mkHost = import ./mkHost.nix { inherit inputs nixpkgs overlays; };
  mkHome = import ./mkHome.nix { inherit inputs nixpkgs overlays; };
  discover = import ./discover.nix { inherit lib; };
in
{
  inherit mkHost mkHome;
  inherit (discover) discoverHosts discoverHomes;
}
