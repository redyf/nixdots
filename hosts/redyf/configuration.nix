{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/programs
    ../../modules/system
    ../../modules/services.nix
    ../../modules/stylix.nix
    ../../modules/virtualisation.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    docker-compose
  ];

  system.stateVersion = "22.11"; # Did you read the comment?
}
