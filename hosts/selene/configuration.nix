{
  config,
  pkgs,
  ...
}:
{
  # Shared modules and profiles (roles) come from mkHost + meta.nix.
  imports = [ ./hardware-configuration.nix ];

  # Configure the user with specific groups
  myConfig = {
    users = {
      enable = true;
      isNormalUser = true;
      description = "Laptop host"; # Optional - defaults to username if not specified
      hashedPasswordFile = config.sops.secrets."users/${config.myConfig.users.username}/password".path;
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

    services.fstrim.enable = false;

    system = {
      amd.enable = true;
      intel.enable = false;
      kernel.enable = true;
      power-management.enable = false;
      sops = {
        enable = true;
        # The selene age recipient is derived from the SSH host key.
        keyFile = null;
      };
    };
  };

  boot = {
    kernelParams = [
      "i8042.reset"
      "i8042.direct"
    ];
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
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
