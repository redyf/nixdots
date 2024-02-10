{ inputs
, options
, config
, pkgs
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.system.nix;
  manixFlake = inputs.manix.packages.${pkgs.system}.manix;
in
{
  options.system.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nixUnstable "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nil
      statix
      nixfmt
      nix-index
      nix-init
      nix-prefetch-git
      manixFlake
    ];

    nix =
      let
        users = [ "root" config.user.name ];
      in
      {
        inherit (cfg) package;

        settings =
          {
            experimental-features = "nix-command flakes";
            http-connections = 50;
            warn-dirty = false;
            log-lines = 50;
            sandbox = "relaxed";
            auto-optimise-store = true;
            substituters = [ "https://hyprland.cachix.org" ];
            trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
            trusted-users = users;
            allowed-users = users;
          }
          // (lib.optionalAttrs config.tools.direnv.enable {
            keep-outputs = true;
            keep-derivations = true;
          });

        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };

        # flake-utils-plus
        generateRegistryFromInputs = true;
        generateNixPathFromInputs = true;
        linkInputs = true;
      };
  };
}
