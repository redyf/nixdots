{ lib, ... }:
{
  myConfig = {
    users = {
      description = "Example user";
      initialPassword = "nixos";
      groups.input = true;
    };

    desktop.gnome.enable = true;

    services.displayManager.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = lib.mkDefault true;
    efi.canTouchEfiVariables = lib.mkDefault false;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  system.stateVersion = "25.05";
}
