{
  inputs,
  nixpkgs,
  overlays ? [ ],
}:
{
  username,
  # Host this configuration targets; home/hosts/<hostname>.nix is imported
  # when present (monitors and other machine-specific user settings).
  hostname,
  roles ? [ ],
  # Same value as mkHost's `keyboard` (from hosts/<hostname>/meta.nix).
  keyboard ? {
    layout = "us";
    variant = "";
  },
  system ? "x86_64-linux",
  homeDirectory ? "/home/${username}",
  stateVersion ? "25.05",
  modules ? [ ],
  homePath ? ../home,
}:
let
  hostFile = homePath + "/hosts/${hostname}.nix";
in
inputs.home-manager.lib.homeManagerConfiguration {
  # Standalone Home Manager re-imports nixpkgs from `nixpkgs.*` options, so
  # config and overlays are set as module options below, not here.
  pkgs = nixpkgs.legacyPackages.${system};
  extraSpecialArgs = {
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
    (homePath + "/users/${username}.nix")
  ]
  ++ nixpkgs.lib.optional (builtins.pathExists hostFile) hostFile
  ++ [
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
