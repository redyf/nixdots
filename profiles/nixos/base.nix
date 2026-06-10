{ lib, pkgs, ... }:
{
  myConfig = {
    cli = {
      enable = lib.mkDefault true;
      nh.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
    };

    desktop = {
      enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault true;
      xserver.enable = lib.mkDefault true;
    };

    development = {
      enable = lib.mkDefault true;
      ansible.enable = lib.mkDefault false;
      aws.enable = lib.mkDefault true;
      k3s.enable = lib.mkDefault false;
      localstack.enable = lib.mkDefault false;
      nginx.enable = lib.mkDefault false;
      terraform.enable = lib.mkDefault false;
    };

    gaming = {
      enable = lib.mkDefault true;
      steam.enable = lib.mkDefault true;
    };

    nix = {
      enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
    };

    services = {
      enable = lib.mkDefault true;
      autorandr.enable = lib.mkDefault true;
      displayManager.enable = lib.mkDefault true;
      flatpak.enable = lib.mkDefault false;
      input.enable = lib.mkDefault true;
    };

    system = {
      enable = lib.mkDefault true;
      audio.enable = lib.mkDefault true;
      boot.enable = lib.mkDefault true;
      environment.enable = lib.mkDefault true;
      hardware.enable = lib.mkDefault true;
      keymap.enable = lib.mkDefault true;
      locale.enable = lib.mkDefault true;
      networking.enable = lib.mkDefault true;
      security.enable = lib.mkDefault true;
      ssh.enable = lib.mkDefault true;
      systemd.enable = lib.mkDefault true;
      time.enable = lib.mkDefault true;
      xdg-portal.enable = lib.mkDefault true;
      zram.enable = lib.mkDefault true;
    };

    themes = {
      enable = lib.mkDefault true;
      stylix.enable = lib.mkDefault true;
    };

    virtualization = {
      enable = lib.mkDefault true;
      docker.enable = lib.mkDefault true;
      virtmanager.enable = lib.mkDefault false;
      virtualbox.enable = lib.mkDefault false;
    };
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    docker-compose
    git
    ntfs3g
  ];
}
