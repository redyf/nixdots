{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nix.nix
    ../../modules/services.nix
    ../../modules/stylix.nix
    ../../modules/users.nix
    ../../modules/virtualisation.nix
    ../../modules/systemd.nix
    ../../modules/programs
    ../../modules/system
  ];

  environment.systemPackages = with pkgs; [
    git
    docker-compose
  ];

  system.stateVersion = "22.11"; # Did you read the comment?
}
