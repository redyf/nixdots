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

  # Configure the user with specific groups
  myConfig = {
    users = {
      enable = true;
      username = "selene";
      isNormalUser = true;
      description = "selene"; # Optional - defaults to username if not specified
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
      appimage.enable = false;
      nh.enable = true;
      zsh.enable = true;
    };

    desktop = {
      enable = true;
      gnome.enable = false;
      hyprland.enable = false;
      sway.enable = true;
      xserver.enable = true;
    };

    development = {
      enable = false;
      ansible.enable = true;
      aws.enable = true;
      k3s.enable = false;
      k8s.enable = true;
      nginx.enable = true;
      terraform.enable = true;
    };

    gaming = {
      enable = false;
      steam.enable = false;
    };

    hardware = {
      enable = false;
      nvidia.enable = false;
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
      fstrim.enable = false;
      input.enable = true;
    };

    system = {
      enable = true;
      audio.enable = true;
      boot.enable = true;
      environment.enable = true;
      hardware.enable = true;
      intel.enable = true;
      keymap.enable = true;
      locale.enable = true;
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
