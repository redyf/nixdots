{
  config,
  homeDirectory,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.myConfig.nix.nix;
in
{
  config = lib.mkIf (config.myConfig.nix.enable && cfg.enable) {
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };
    nix = {
      package = pkgs.nixVersions.stable;
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
          "${username}"
        ];
        substituters = [
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
          "https://cache.nixos.org"
          "https://ghostty.cachix.org"
        ];
        trusted-substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        ];
      };
      gc = {
        automatic = false;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      distributedBuilds = false;
      buildMachines = [
        {
          hostName = "raspberry";
          sshUser = "redyf";
          sshKey = "${homeDirectory}/.ssh/id_ed25519";
          systems = [ "aarch64-linux" ];
          protocol = "ssh-ng";
          speedFactor = 1;
          supportedFeatures = [
            "nixos-test"
            "benchmark"
            "big-parallel"
            "kvm"
          ];
        }
      ];
    };
  };
}
