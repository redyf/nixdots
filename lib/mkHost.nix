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
  # XKB layout of this machine's keyboard, shared by NixOS (X11, console)
  # and Home Manager (Hyprland, Sway) through the `keyboard` module argument.
  keyboard ? {
    layout = "us";
    variant = "";
  },
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
      keyboard
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
    # Input modules every host needs (modules/ sets their options). Feature
    # specific ones (hyprland, serpantinum, nvibrant) are imported by roles.
    inputs.stylix.nixosModules.stylix
    inputs.sops-nix.nixosModules.sops
  ]
  ++ map (role: profilesPath + "/${role}.nix") roles
  ++ nixpkgs.lib.optionals (builtins.pathExists (hostsPath + "/${hostname}/disko.nix")) [
    inputs.disko.nixosModules.disko
    (hostsPath + "/${hostname}/disko.nix")
  ]
  ++ modules;
}
