{ ... }:
{
  # Shared modules and profiles (roles) come from mkHost + meta.nix.
  imports = [ ./hardware-configuration.nix ];

  myConfig = {
    users = {
      description = "Laptop host";
      groups = {
        virtualisation = true;
        input = true;
      };
    };

    desktop.sway.enable = true;

    virtualization.virtualbox.enable = true;

    system = {
      amd.enable = true;
      kernel.enable = true;
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

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  networking.hostId = "fbb56d98";

  hardware = {
    enableRedistributableFirmware = true;
    # serpantinum enables bluetooth by default.
    bluetooth.enable = false;
  };

  system.stateVersion = "25.05"; # Don't change this
}
