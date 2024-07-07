{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  raspberry-pi-nix.uboot.enable = true;

  networking = {
    hostName = "raspberry"; # Define your hostname.
    firewall.enable = false;
    wireless = {
      enable = true;
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    bluez
    bluez-tools
    cowsay
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  hardware = {
    bluetooth.enable = true;
    raspberry-pi = {
      config = {
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
  };

  time.timeZone = "America/Bahia";
  console = {keyMap = "br-abnt2";};

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
  };

  # just for access after install to continue provisioning

  system.stateVersion = "23.11";
}
