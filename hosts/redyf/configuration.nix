{
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/programs
    ../../modules/system
    # ../../modules/gaming
    ../../modules/nix.nix
    ../../modules/services.nix
    ../../modules/stylix.nix
    ../../modules/virtualisation.nix
    ../../modules/gaming/steam.nix
  ];

  users.users = {
    ${username} = {
      isNormalUser = true;
      description = username;
      initialPassword = "123456";
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
        "input"
        "docker"
        "kvm"
        "libvirtd"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    docker-compose
  ];

  system.stateVersion = "22.11"; # Don't change this
}
