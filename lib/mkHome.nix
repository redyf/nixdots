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
let
  pkgs = import nixpkgs {
    inherit system overlays;
    config.allowUnfree = true;
  };
in
inputs.home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = {
    inherit
      inputs
      username
      homeDirectory
      stateVersion
      ;
  };
  modules = [
    (homePath + "/users/${username}.nix")
    inputs.stylix.homeModules.stylix
    {
      home = {
        inherit username stateVersion homeDirectory;
      };
      programs.home-manager.enable = true;
    }
  ]
  ++ modules;
}
