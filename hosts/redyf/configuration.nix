{
  inputs,
  pkgs,
  config,
  ...
}: {
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
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "0"; # Controls if Adaptive Sync should be used. Recommended to set as “0” to avoid having problems on some games.
      XCURSOR_THEME = "macOS-BigSur";
      XCURSOR_SIZE = "32";
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
    hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    jack.enable = false;
    pulse.enable = true;
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
      enable = false;
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

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Iosevka Aile, Times, Noto Serif"];
        sansSerif = ["Iosevka Aile, Helvetica Neue LT Std, Helvetica, Noto Sans"];
        monospace = ["Courier Prime, Courier, Noto Sans Mono"];
      };
    };
  };

  programs.nix-ld = {
    enable = true;
    package = inputs.nix-ld-rs.packages.${pkgs.system}.nix-ld-rs;
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
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # suites = {
  #   common = enabled;
  #   desktop = enabled;
  #   development = enabled;
  #   music = enabled;
  #   video = enabled;
  #   social = enabled;
  #   gaming = disabled;
  #   rice = enabled;
  # };

  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
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

  # Configure keymap in X11
  services = {
    sshd.enable = true;
    # Enable CUPS to print documents.
    # printing.enable = true;
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      displayManager = {
        gdm.enable = true;
      };
      desktopManager = {
        xfce.enable = true;
      };
      windowManager = {
        xmonad = {
          enable = false;
          enableContribAndExtras = true;
        };
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
      xkb = {
        variant = "";
        layout = "br";
      };
      videoDrivers = ["nvidia"];
    };
    logmein-hamachi.enable = false;
    flatpak.enable = false;
  };

  environment.systemPackages = with pkgs; [
    git
    playerctl
    inputs.xdg-portal-hyprland.packages.${system}.xdg-desktop-portal-hyprland
  ];

  system.stateVersion = "22.11"; # Did you read the comment?
}
