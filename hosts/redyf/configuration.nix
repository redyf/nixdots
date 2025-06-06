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
    ../../modules
  ];

  fileSystems."/mnt/windows" = {
    device = "UUID=F0FEDBD0FEDB8D6A";
    fsType = "ntfs";
    options = [
      "uid=1000"
      "gid=100"
      "umask=022"
      "rw"
      "nofail"
    ];
  };

  # Configure the user with specific groups
  myConfig = {
    users = {
      enable = true;
      username = "redyf";
      isNormalUser = true;
      description = "redyf"; # Optional - defaults to username if not specified
      initialPassword = "123456";
      shell = pkgs.zsh;

      groups = {
        # development = true;
        virtualisation = true;
        # media = true;
        input = true;
      };
    };

    gaming = {
      enable = true;
      steam.enable = true;
    };

    hardware = {
      enable = true;
      nvidia.enable = true;
    };

    nix = {
      enable = true;
      nix.enable = true;
    };

    programs = {
      enable = true;
      hyprland.enable = true;
      k3s.enable = true;
      nh.enable = true;
      zsh.enable = true;
    };

    services = {
      enable = true;
      services.enable = true;
      xserver.enable = true;
    };

    system = {
      enable = true;
      audio.enable = true;
      boot.enable = true;
      environment.enable = true;
      hardware.enable = true;
      keymap.enable = true;
      locale.enable = true;
      networking.enable = true;
      security.enable = true;
      ssh.enable = true;
      systemd.enable = true;
      time.enable = true;
      xdg-portal.enable = true;
      zram.enable = true;
    };

    themes = {
      enable = true;
      stylix.enable = true;
    };

    virtualization = {
      enable = true;
      docker.enable = true;
    };
  };

  # users.users = {
  #   ${username} = {
  #     isNormalUser = true;
  #     description = username;
  #     initialPassword = "123456";
  #     shell = pkgs.zsh;
  #     extraGroups = [
  #       "networkmanager"
  #       "wheel"
  #       "input"
  #       "docker"
  #       "kvm"
  #       "libvirtd"
  #     ];
  #   };
  # };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    docker-compose
    ntfs3g
  ];

  system.stateVersion = "22.11"; # Don't change this
}
