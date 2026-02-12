{
  inputs,
  lib,
  pkgs,
  username,
  homeDirectory,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  # fileSystems."/mnt/windows" = {
  #   device = "UUID=F0FEDBD0FEDB8D6A";
  #   fsType = "ntfs";
  #   options = [
  #     "uid=1000"
  #     "gid=100"
  #     "umask=022"
  #     "rw"
  #     "nofail"
  #   ];
  # };

  # Configure the user with specific groups
  myConfig = {
    users = {
      enable = true;
      username = "redyf";
      isNormalUser = true;
      description = "Desktop host"; # Optional - defaults to username if not specified
      initialPassword = "123456";
      shell = pkgs.zsh;

      groups = {
        # development = true;
        virtualisation = true;
        # media = true;
        input = true;
      };
    };

    cli = {
      enable = true;
      appimage.enable = true;
      nh.enable = true;
      zsh.enable = true;
    };

    desktop = {
      enable = true;
      hyprland.enable = true;
      i3.enable = true;
      kde.enable = false;
      sway.enable = false;
      xserver.enable = true;
    };

    development = {
      enable = true;
      ansible.enable = false;
      aws.enable = true;
      k3s.enable = false;
      k8s.enable = false;
      localstack.enable = true;
      nginx.enable = false;
      terraform.enable = true;
    };

    gaming = {
      enable = true;
      gamescope.enable = true;
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

    services = {
      enable = true;
      autorandr.enable = true;
      displayManager.enable = true;
      flatpak.enable = false;
      fstrim.enable = true;
      input.enable = true;
      jackett.enable = false;
    };

    system = {
      enable = true;
      ananicy.enable = true;
      audio.enable = true;
      boot.enable = true;
      environment.enable = true;
      hardware.enable = true;
      intel.enable = true;
      kernel.enable = true;
      keymap.enable = true;
      locale.enable = true;
      mime-types.enable = true;
      networking.enable = true;
      power-management.enable = true;
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
      virtmanager.enable = false;
      virtualbox.enable = false;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    docker-compose
    ntfs3g
  ];

  system.stateVersion = "22.11"; # Don't change this
}
