{
  username,
  pkgs,
  homeDirectory,
  ...
}: {
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      auto-optimise-store = true;
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      sandbox = "relaxed";
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://raspberry-pi-nix.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o="
      ];
      trusted-users = ["${username}"];
    };
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "raspberry";
        sshUser = "redyf";
        sshKey = "${homeDirectory}/.ssh/id_ed25519_buildmachine";
        systems = ["aarch64-linux"];
        protocol = "ssh-ng";
        maxJobs = 1;
        speedFactor = 1;
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
      }
    ];
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
