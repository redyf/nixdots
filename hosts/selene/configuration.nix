{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  raspberry-pi-nix.uboot.enable = true;
  raspberry-pi-nix.libcamera-overlay.enable = false;

  networking = {
    hostName = "raspberry"; # Define your hostname.
    networkmanager.enable = true;
    firewall.enable = false;
    #wireless = {
    #  enable = true;
    #};
  };

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
    xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    bluez
    bluez-tools
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  hardware = {
    bluetooth.enable = true;
    raspberry-pi = {
      config = {
        pi5 = {
          dt-overlays = {
            vc4-kms-v3d-pi5 = {
              enable = true;
              params = {};
            };
          };
        };
        all = {
          base-dt-params = {
            # enable autoprobing of bluetooth driver
            # https://github.com/raspberrypi/linux/blob/c8c99191e1419062ac8b668956d19e788865912a/arch/arm/boot/dts/overlays/README#L222-L224
            krnbt = {
              enable = true;
              value = "on";
            };
          };
        };
      };
    };
  };

  users.users = {
    root.initialPassword = "root";
    selene = {
      isNormalUser = true;
      description = "My RaspberryPI Host";
      initialPassword = "123456";
      shell = pkgs.zsh;
      extraGroups = ["networkmanager" "wheel" "input" "docker" "kvm" "libvirtd"];
    };
  };

  programs = {
    zsh.enable = true;
    sway = {
    enable = true;
    };
  };

  xdg.portal = {
  enable = true;
  extraPortals = [
  pkgs.xdg-desktop-portal-wlr
  ];
  };

  time.timeZone = "America/Bahia";
  console = {keyMap = "br-abnt2";};

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
  };

  # just for access after install to continue provisioning

  system.stateVersion = "23.11";
}
