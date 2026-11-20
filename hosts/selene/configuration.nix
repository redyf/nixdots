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

    development.terraform.enable = true;

    virtualization.virtualbox.enable = true;

    system = {
      amd.enable = true;
      kernel.enable = true;
      sops = {
        enable = true;
        # The selene age recipient is derived from the SSH host key.
        keyFile = null;
      };
      tailscale.enable = true;
    };
  };

  services.gnome.gcr-ssh-agent.enable = false;

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
    bluetooth.enable = false;
  };

  system.stateVersion = "25.05"; # Don't change this
}
