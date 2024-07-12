{
  inputs,
  pkgs,
  config,
  ...
}: let
  theme = "oxocarbon-dark";
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    kernelModules = ["v4l2loopback"]; # Autostart kernel modules on boot
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback]; # loopback module to make OBS virtual camera work
    kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
    supportedFilesystems = ["ntfs"];
    loader = {
      systemd-boot = {
        enable = false;
        # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
        editor = false;
      };
      timeout = 10;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 8;
        theme =
          pkgs.fetchFromGitHub
          {
            owner = "Lxtharia";
            repo = "minegrub-theme";
            rev = "193b3a7c3d432f8c6af10adfb465b781091f56b3";
            sha256 = "1bvkfmjzbk7pfisvmyw5gjmcqj9dab7gwd5nmvi8gs4vk72bl2ap";
          };
      };
    };
  };

  hardware = {
    nvidia = {
      open = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "0"; # Controls if Adaptive Sync should be used. Recommended to set as “0” to avoid having problems on some games.
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      GTK_THEME = "Catppuccin-Mocha-Compact-Blue-dark";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
      WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor rendering issue on wlr nvidia.
      DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox"; # Set default browser
    };
    shellAliases = {nvidia-settings = "nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings";};
  };

  # Configure console keymap
  console = {keyMap = "br-abnt2";};

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
    # no need to wait interfaces to have an IP to continue booting
    dhcpcd.wait = "background";
    # avoid checking if IP is already taken to boot a few seconds faster
    dhcpcd.extraConfig = "noarp";
    hostName = "redyf"; # Define your hostname.
    firewall = {
      enable = true;
    };
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  users = {
    users = {
      redyf = {
        isNormalUser = true;
        description = "redyf";
        initialPassword = "123456";
        shell = pkgs.zsh;
        extraGroups = ["networkmanager" "wheel" "input" "docker" "kvm" "libvirtd"];
      };
    };
  };

  # Enable and configure `doas`.
  security = {
    sudo = {
      enable = true;
    };
    doas = {
      enable = true;
      extraRules = [
        {
          users = ["redyf"];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = with pkgs; xdg-desktop-portal-hyprland;
    };
    noisetorch.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/redyf/nixdots";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  stylix = {
    enable = true;
    autoEnable = true;
    image = ./9ovcXG0Wo4P7FQPe.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
    fonts = {
      monospace = {
        package = with pkgs; inputs.font-flake.packages.${system}.sf-mono;
        name = "Liga SFMono Nerd Font Medium";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sizes = {
        applications = 10;
        terminal = 12;
        desktop = 10;
        popups = 11;
      };
    };
    opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 1.0;
    };
    polarity = "dark";
    targets = {
      grub.enable = false;
      gnome.enable = false;
      gtk.enable = true;
      nixos-icons.enable = true;
    };
  };

  # Enables docker in rootless mode
  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    # Enables virtualization for virt-manager
    libvirtd.enable = true;
  };

  time.timeZone = "America/Bahia";

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

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      auto-optimise-store = true;
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      sandbox = "relaxed";
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Change systemd stop job timeout in NixOS configuration (Default = 90s)
  systemd = {
    services.NetworkManager-wait-online.enable = false;
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  sound.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      jack.enable = false;
      pulse.enable = true;
      audio.enable = true;
    };

    fstrim.enable = true;
    sshd.enable = true;
    mysql = {
      enable = false;
      package = pkgs.mysql80;
    };
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        accelProfile = "flat";
      };
    };
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        sessionCommands = ''
          xset r rate 150 25
          xrandr --output DP-0 --mode 1920x1080 --rate 165 --primary
          nitrogen --restore
        '';
      };
      desktopManager = {
        xfce.enable = true;
      };
      windowManager = {
        awesome = {
          enable = false;
          luaModules = with pkgs.luaPackages; [
            luarocks
          ];
        };
      };
      xkb = {
        variant = "";
        layout = "br";
      };
      videoDrivers = ["nvidia"];
    };
    logmein-hamachi.enable = false;
    flatpak.enable = false;
    autorandr = {
      enable = true;
      profiles = {
        redyf = {
          config = {
            DP-0 = {
              enable = true;
              primary = true;
              mode = "1920x1080";
              rate = "165.00";
              position = "0x0";
            };
          };
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    git
    docker-compose
  ];

  system.stateVersion = "22.11"; # Did you read the comment?
}
