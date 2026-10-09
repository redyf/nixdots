{
  inputs,
  nixpkgs,
  overlays ? [ ],
}:
{
  username,
  system ? "x86_64-linux",
  homeDirectory ? "/home/${username}",
  stateVersion ? "25.05",
  modules ? [ ],
  homePath ? ../home,
}:
inputs.home-manager.lib.homeManagerConfiguration {
  # Standalone Home Manager re-imports nixpkgs from `nixpkgs.*` options, so
  # config and overlays are set as module options below, not here.
  pkgs = nixpkgs.legacyPackages.${system};
  extraSpecialArgs = {
    inherit
      inputs
      username
      homeDirectory
      ;
  };
  modules = [
    (homePath + "/users/${username}.nix")
    inputs.stylix.homeModules.stylix
    {
      home = {
        inherit username stateVersion homeDirectory;
      };
      nixpkgs = {
        config = import ./nixpkgs-config.nix;
        inherit overlays;
      };
      programs.home-manager.enable = true;
    }
  ]
  ++ modules;
}
