{
  config,
  inputs,
  username,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.nix;
  caches = [
    {
      url = "https://cache.nixos.org";
      key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    }
    {
      url = "https://nix-community.cachix.org";
      key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
    }
    {
      url = "https://hyprland.cachix.org";
      key = "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=";
    }
    {
      url = "https://cache.numtide.com";
      key = "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=";
    }
  ];
in
{
  options.myConfig.nix.enable = lib.mkEnableOption "nix daemon settings";

  config = lib.mkIf cfg.enable {
    nix = {
      package = pkgs.nixVersions.stable;
      # Pin `nix run <input>#...` / `nix shell <input>#...` to this flake's
      # lock. nixpkgs is already registered by nixpkgs.lib.nixosSystem.
      registry = lib.mapAttrs (_: flake: { inherit flake; }) (
        lib.filterAttrs (
          name: input: name != "self" && name != "nixpkgs" && input ? _type && input._type == "flake"
        ) inputs
      );
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        auto-optimise-store = true;
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        sandbox = "relaxed";
        trusted-users = [
          username
        ];
        substituters = map (cache: cache.url) caches;
        trusted-substituters = map (cache: cache.url) caches;
        trusted-public-keys = map (cache: cache.key) caches;
      };
      gc = {
        automatic = false;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
  };
}
