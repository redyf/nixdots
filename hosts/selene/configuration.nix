{
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/nixos/base.nix
    ../../modules
  ];

  # Configure the user with specific groups
  myConfig = {
    users = {
      enable = true;
      username = "selene";
      isNormalUser = true;
      description = "Laptop host"; # Optional - defaults to username if not specified
      # TODO: configure sops-nix for selene (like desktop host) and use hashedPasswordFile
      shell = pkgs.zsh;

      groups = {
        # development = true;
        virtualisation = true;
        # media = true;
        input = true;
      };
    };

    cli = {
      appimage.enable = false;
    };

    desktop = {
      sway.enable = true;
    };

    hardware = {
      enable = false;
      nvidia.enable = false;
    };

    services = {
      fstrim.enable = false;
      tlp.enable = true;
      upower.enable = true;
    };

    system = {
      amd.enable = true;
      intel.enable = false;
      kernel.enable = true;
      power-management.enable = false;
    };
  };

  boot = {
    kernelParams = [
      "i8042.reset"
      "i8042.direct"
    ];
    supportedFilesystems = [ "zfs" ];
    extraModprobeConfig = ''
      options zfs zfs_arc_max=4294967296
    '';
  };

  services = {
    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
  };

  networking.hostId = "fbb56d98";

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = false;
  };

  system.stateVersion = "25.05"; # Don't change this
}
