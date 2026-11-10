{ inputs }:
let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;

  # Systems for per-system outputs (devShells, formatter, checks). Hosts pick
  # their own `system` in meta.nix; add an entry here when a host needs it.
  systems = [ "x86_64-linux" ];

  hosts = import ./hosts.nix { inherit lib; } ../hosts;

  specialArgs =
    host:
    {
      inherit inputs;
      theme = import ../theme.nix;
    }
    // removeAttrs host [
      "system"
      "roles"
    ];

  mkHost = import ./mkHost.nix { inherit inputs specialArgs; };
  mkHome = import ./mkHome.nix { inherit inputs specialArgs; };

  # One Home Manager configuration per host, keyed "<username>@<hostname>"
  # (the name `home-manager` and `nh home switch` try first). The user needs a
  # users/<username>.nix.
  homedHosts = lib.filterAttrs (_: host: builtins.pathExists ../users/${host.username}.nix) hosts;
in
{
  forAllSystems = lib.genAttrs systems;
  nixosConfigurations = lib.mapAttrs (_: mkHost) hosts;
  homeConfigurations = lib.mapAttrs' (
    hostname: host: lib.nameValuePair "${host.username}@${hostname}" (mkHome host)
  ) homedHosts;
  mkHomeEvalCheck = import ./checks.nix;
}
