{
  inputs,
  specialArgs,
}:
{
  hostname,
  system,
  username,
  homeDirectory,
  ...
}@host:
let
  hostHome = ../hosts/${hostname}/home.nix;
in
inputs.home-manager.lib.homeManagerConfiguration {
  # Standalone Home Manager re-imports nixpkgs from `nixpkgs.*` options, so
  # config is set as a module option below, not here.
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  extraSpecialArgs = specialArgs host;
  modules = [
    ../home
    ../users/${username}.nix
  ]
  ++ inputs.nixpkgs.lib.optional (builtins.pathExists hostHome) hostHome
  ++ [
    inputs.stylix.homeModules.stylix
    {
      home = {
        inherit username homeDirectory;
        stateVersion = "25.05";
        sessionPath = [ "$HOME/.local/bin" ];
      };
      nixpkgs.config = import ./nixpkgs-config.nix;
      programs.home-manager.enable = true;
    }
  ];
}
