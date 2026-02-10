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
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
        ];
        trusted-substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
        extra-substituters = [
          "https://attic.xuyh0120.win/lantian"
          "https://cache.garnix.io"
        ];
        extra-trusted-public-keys = [
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
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
