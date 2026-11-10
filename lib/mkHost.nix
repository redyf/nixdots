{
  inputs,
  specialArgs,
}:
{
  hostname,
  system,
  roles,
  ...
}@host:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = specialArgs host;
  modules = [
    ../modules
    {
      nixpkgs = {
        hostPlatform = system;
        config = import ./nixpkgs-config.nix;
      };
      networking.hostName = hostname;
    }
    ../hosts/${hostname}/configuration.nix
    # Input modules every host needs (modules/ sets their options). Feature
    # specific ones (hyprland, serpantinum, nvibrant) are imported by roles.
    inputs.stylix.nixosModules.stylix
    inputs.sops-nix.nixosModules.sops
  ]
  ++ map (role: ../profiles/nixos/${role}.nix) roles
  ++ inputs.nixpkgs.lib.optionals (builtins.pathExists ../hosts/${hostname}/disko.nix) [
    inputs.disko.nixosModules.disko
    ../hosts/${hostname}/disko.nix
  ];
}
