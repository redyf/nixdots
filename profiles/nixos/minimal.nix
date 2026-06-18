{ lib, pkgs, ... }:
{
  myConfig = {
    cli = {
      enable = lib.mkDefault true;
      appimage.enable = lib.mkDefault false;
      nh.enable = lib.mkDefault false;
      zsh.enable = lib.mkDefault true;
    };

    desktop = {
      enable = lib.mkDefault false;
      gnome.enable = lib.mkDefault false;
      hyprland.enable = lib.mkDefault false;
      i3.enable = lib.mkDefault false;
      kde.enable = lib.mkDefault false;
      sway.enable = lib.mkDefault false;
      xserver.enable = lib.mkDefault false;
    };

    development = {
      enable = lib.mkDefault false;
      ansible.enable = lib.mkDefault false;
      aws.enable = lib.mkDefault false;
      k3s.enable = lib.mkDefault false;
      localstack.enable = lib.mkDefault false;
      nginx.enable = lib.mkDefault false;
      terraform.enable = lib.mkDefault false;
    };

    gaming = {
      enable = lib.mkDefault false;
      gamescope.enable = lib.mkDefault false;
      steam.enable = lib.mkDefault false;
    };

    hardware = {
      enable = lib.mkDefault false;
      nvidia.enable = lib.mkDefault false;
    };

    nix = {
      enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
    };

    services = {
      enable = lib.mkDefault true;
      autorandr.enable = lib.mkDefault false;
      displayManager.enable = lib.mkDefault false;
      flatpak.enable = lib.mkDefault false;
      fstrim.enable = lib.mkDefault true;
      input.enable = lib.mkDefault true;
      jackett.enable = lib.mkDefault false;
      tlp.enable = lib.mkDefault false;
      upower.enable = lib.mkDefault false;
    };

    system = {
      enable = lib.mkDefault true;
      amd.enable = lib.mkDefault false;
      ananicy.enable = lib.mkDefault false;
      audio.enable = lib.mkDefault true;
      boot.enable = lib.mkDefault false;
      cachy.enable = lib.mkDefault false;
      environment.enable = lib.mkDefault true;
      hardware.enable = lib.mkDefault true;
      intel.enable = lib.mkDefault false;
      kernel.enable = lib.mkDefault false;
      keymap.enable = lib.mkDefault true;
      locale.enable = lib.mkDefault true;
      mime-types.enable = lib.mkDefault true;
      networking.enable = lib.mkDefault true;
      nvibrant.enable = lib.mkDefault false;
      power-management.enable = lib.mkDefault false;
      security.enable = lib.mkDefault true;
      sops.enable = lib.mkDefault false;
      ssh.enable = lib.mkDefault false;
      systemd.enable = lib.mkDefault true;
      tailscale.enable = lib.mkDefault false;
      time.enable = lib.mkDefault true;
      xdg-portal.enable = lib.mkDefault false;
      zram.enable = lib.mkDefault true;
    };

    themes = {
      enable = lib.mkDefault false;
      stylix.enable = lib.mkDefault false;
    };

    virtualization = {
      enable = lib.mkDefault false;
      docker.enable = lib.mkDefault false;
      virtmanager.enable = lib.mkDefault false;
      virtualbox.enable = lib.mkDefault false;
    };
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;

  environment.systemPackages = with pkgs; [ git ];
}
