{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/programs
    ../../modules/system
    ../../modules/services.nix
    ../../modules/stylix.nix
    # ../../modules/users.nix
    ../../modules/virtualisation.nix
  ];

  users.users = {
    redyf = {
      isNormalUser = true;
      description = "redyf";
      initialPassword = "123456";
      shell = pkgs.zsh;
      extraGroups = ["networkmanager" "wheel" "input" "docker" "kvm" "libvirtd"];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    docker-compose
  ];

  system.stateVersion = "22.11"; # Did you read the comment?
}
