{
  pkgs,
  lib,
  ...
}:
{
  time.timeZone = "America/Bahia";
  console = {
    keyMap = "br-abnt2";
  };
  i18n = {
    defaultLocale = "pt_BR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  users.users.root.initialPassword = "root";
  networking = {
    hostName = "minimal";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      wlan0.useDHCP = true;
      eth0.useDHCP = true;
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  # Overlays for raspberry-pi
  raspberry-pi-nix = {
    board = "bcm2712"; # bcm2711 if on rpi4 or below
    uboot.enable = false;
    libcamera-overlay.enable = false;
  };

  hardware = {
    bluetooth.enable = true;
    raspberry-pi = {
      config = {
        pi5 = {
          dt-overlays = {
            vc4-kms-v3d-pi5 = {
              enable = true;
              params = { };
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

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      auto-optimise-store = true;
      log-lines = 50;
      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
