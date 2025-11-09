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
      description = "redyf"; # Optional - defaults to username if not specified
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
      gnome.enable = false;
      hyprland.enable = true;
      niri.enable = false;
      sway.enable = false;
      xserver.enable = true;
    };

    development = {
      enable = true;
      k3s.enable = false;
      k8s.enable = true;
    };

    gaming = {
      enable = true;
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
      virtmanager.enable = true;
      virtualbox.enable = false;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    docker-compose
    ntfs3g
  ];

  # microvm.vms.selene = {
  #   config = {
  #     microvm = {
  #       vcpu = 4;
  #       mem = 8192;
  #       hypervisor = "qemu";
  #       storeOnDisk = true;
  #       volumes = [
  #         {
  #           mountPoint = "/";
  #           image = "/var/lib/microvms/selene-store.img";
  #           size = 50 * 1024; # 20GB
  #         }
  #       ];
  #       interfaces = [
  #         {
  #           type = "user";
  #           id = "eth0";
  #           mac = "52:54:00:12:34:56"; # valor qualquer válido
  #         }
  #       ];
  #     };
  #
  #     networking = {
  #       hostName = "selene";
  #       useDHCP = true;
  #       # useNetworkd = false;
  #       # interfaces.eth0 = {
  #       #   useDHCP = false;
  #       #   ipv4.addresses = [
  #       #     {
  #       #       address = "10.0.0.2";
  #       #       prefixLength = 24;
  #       #     }
  #       #   ];
  #       # };
  #       # defaultGateway = "10.0.0.1";
  #       # nameservers = [ "8.8.8.8" ];
  #       firewall.enable = false;
  #     };
  #
  #     boot.loader.grub.enable = false;
  #
  #     # Compartilhar o nix store do host (opcional)
  #     # shares = [
  #     #   {
  #     #     source = "/nix/store";
  #     #     mountPoint = "/nix/.ro-store";
  #     #     tag = "ro-store";
  #     #     proto = "virtiofs";
  #     #   }
  #     # ];
  #
  #     services.openssh = {
  #       enable = true;
  #       ports = [ 48316 ];
  #       settings = {
  #         PasswordAuthentication = false;
  #         PermitRootLogin = "prohibit-password";
  #         KbdInteractiveAuthentication = false;
  #       };
  #     };
  #     users.users.root = {
  #       openssh.authorizedKeys.keyFiles = [ /home/redyf/.ssh/id_ed25519.pub ];
  #     };
  #     environment.systemPackages = [ pkgs.git ];
  #     # microvm.writableStoreOverlay = "/nix/store";
  #     nix.settings.substituters = [
  #       "file:///nix/.ro-store"
  #       "https://cache.nixos.org/"
  #     ];
  #   };
  # };

  system.stateVersion = "22.11"; # Don't change this
}
