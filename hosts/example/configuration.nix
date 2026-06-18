{
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../../modules
    ../../profiles/nixos/minimal.nix
  ];

  myConfig = {
    users = {
      enable = true;
      inherit username;
      description = "Example user";
      initialPassword = "nixos";
      shell = pkgs.zsh;

      groups.input = true;
    };

    desktop = {
      enable = true;
      gnome.enable = true;
    };

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
