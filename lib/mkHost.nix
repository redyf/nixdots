{
  inputs,
  nixpkgs,
  overlays ? [ ],
}:
{
  hostname,
  system ? "x86_64-linux",
  username,
  homeDirectory ? "/home/${username}",
  # Names of files in profiles/nixos/ to import, e.g. [ "common" "laptop" ].
  roles ? [ ],
  modules ? [ ],
  hostsPath ? ../hosts,
  profilesPath ? ../profiles/nixos,
}:
nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit
      inputs
      username
      homeDirectory
      hostname
      roles
      ;
  };
  modules = [
    ../modules
    {
      nixpkgs = {
        hostPlatform = system;
        config = import ./nixpkgs-config.nix;
        inherit overlays;
      };
    }
    { networking.hostName = hostname; }
    (hostsPath + "/${hostname}/configuration.nix")
    inputs.hyprland.nixosModules.default
    inputs.stylix.nixosModules.stylix
    inputs.sops-nix.nixosModules.sops
    inputs.nvibrant.nixosModules.default
    inputs.serpantinum.nixosModules.default
  ]
  ++ map (role: profilesPath + "/${role}.nix") roles
  ++ nixpkgs.lib.optionals (builtins.pathExists (hostsPath + "/${hostname}/disko.nix")) [
    inputs.disko.nixosModules.disko
    (hostsPath + "/${hostname}/disko.nix")
  ]
  ++ modules;
}
