{
  inputs,
  nixpkgs,
}:
{
  hostname,
  system ? "x86_64-linux",
  username,
  homeDirectory ? "/home/${username}",
  modules ? [ ],
  hostsPath ? ../hosts,
}:
nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit
      inputs
      username
      homeDirectory
      hostname
      ;
  };
  modules = [
    { nixpkgs.hostPlatform = system; }
    { networking.hostName = hostname; }
    (hostsPath + "/${hostname}/configuration.nix")
    inputs.hyprland.nixosModules.default
    inputs.stylix.nixosModules.stylix
    inputs.sops-nix.nixosModules.sops
  ]
  ++ nixpkgs.lib.optionals (builtins.pathExists (hostsPath + "/${hostname}/disko.nix")) [
    inputs.disko.nixosModules.disko
    (hostsPath + "/${hostname}/disko.nix")
  ]
  ++ modules;
}
