{
  inputs,
  nixpkgs,
}:
let
  inherit (nixpkgs) lib;

  mkHost = import ./mkHost.nix { inherit inputs nixpkgs; };
  mkHome = import ./mkHome.nix { inherit inputs nixpkgs; };
  discover = import ./discover.nix { inherit lib; };
in
{
  inherit mkHost mkHome;
  inherit (discover) discoverHosts discoverHomes;
}
