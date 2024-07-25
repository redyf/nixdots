{
  username,
  pkgs,
  homeDirectory,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
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
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    # distributedBuilds = true;
    # buildMachines = [
    #   {
    #     hostName = "raspberry";
    #     sshUser = "redyf";
    #     sshKey = "${homeDirectory}/.ssh/id_ed25519_buildmachine";
    #     systems = ["aarch64-linux"];
    #     protocol = "ssh-ng";
    #     maxJobs = 1;
    #     speedFactor = 1;
    #     supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
    #   }
    # ];
  };
}
