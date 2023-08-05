# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  final,
  prev,
  inputs,
  packages,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
    # Kernel Modules
    kernelModules = ["v4l2loopback"]; # Autostart kernel modules on boot
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback]; # loopback module to make OBS virtual camera work
    loader = {
      systemd-boot.enable = false;
      timeout = 10;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 3;
        theme = pkgs.fetchFromGitHub {
          owner = "shvchk";
          repo = "fallout-grub-theme";
          rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
          sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
        };

        #   theme =
        #     pkgs.fetchFromGitHub
        #     {
        #       owner = "semimqmo";
        #       repo = "sekiro_grub_theme";
        #       rev = "1affe05f7257b72b69404cfc0a60e88aa19f54a6";
        #       sha256 = "02gdihkd2w33qy86vs8g0pfljp919ah9c13cj4bh9fvvzm5zjfn1";
        #     }
        #     + "/Sekiro";
        # };

        # theme = pkgs.fetchFromGitHub
        #   {
        #     owner = "Lxtharia";
        #     repo = "minegrub-theme";
        #     rev = "193b3a7c3d432f8c6af10adfb465b781091f56b3";
        #     sha256 = "1bvkfmjzbk7pfisvmyw5gjmcqj9dab7gwd5nmvi8gs4vk72bl2ap";
        #   };

        #   theme =
        #     pkgs.fetchFromGitHub
        #     {
        #       owner = "Patato777";
        #       repo = "dotfiles";
        #       rev = "d6f96fa59327a936d335f01a7295815250f96ff7";
        #       sha256 = "18mra67kd20bld5zxlvb89ik8psr2pj0v9iaizqpd485sywgqwiq";
        #     }
        #     + "/grub/themes/virtuaverse";
        # };
      };
    };
  };

  # Change systemd stop job timeout in NixOS configuration (Default = 90s)
  systemd = {
    services.NetworkManager-wait-online.enable = false;
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  # Enable networking
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

  # Set your time zone.
  time.timeZone = "America/Bahia";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.windowManager.awesome.enable = true;
  services.xserver.desktopManager.mate.enable = true;
  # services.xserver.windowManager.i3.enable = true;
  # services.xserver.windowManager.bspwm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enables services
  services.logmein-hamachi.enable = false;
  services.flatpak.enable = false;

  # Enable programs
  programs = {
    zsh.enable = true;
    steam.enable = true;
    dconf.enable = true;
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
      nvidiaPatches = true;
    };
  };

  # Use overlays
  nixpkgs.overlays = [
    (
      final: prev: {
        sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
          pname = "sf-mono-liga-bin";
          version = "dev";
          src = inputs.sf-mono-liga-src;
          dontConfigure = true;
          installPhase = ''
            mkdir -p $out/share/fonts/opentype
            cp -R $src/*.otf $out/share/fonts/opentype/
          '';
        };
      }
    )
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      sf-mono-liga-bin
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["SF Pro"];
        sansSerif = ["SF Pro"];
        monospace = ["SF Pro"];
        # serif = ["Times, Noto Serif"];
        # sansSerif = ["Helvetica Neue LT Std, Helvetica, Noto Sans"];
        # monospace = ["Courier Prime, Courier, Noto Sans Mono"];
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Enables docker in rootless mode
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Enables virtualization for virt-manager and virtual box
  virtualisation = {
    libvirtd.enable = true;
    # virtualbox = {
    #   host = {
    #     enable = true;
    #     enableExtensionPack = true;
    #   };
    #   guest = {
    #     enable = true;
    #     x11 = true;
    #   };
    # };
  };
  # users.extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.xserver.videoDrivers = ["nvidia"];

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "0"; # Controls if Adaptive Sync should be used. Recommended to set as “0” to avoid having problems on some games.
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  hardware = {
    nvidia = {
      open = true;
      powerManagement.enable = true;
      modesetting.enable = true;
    };
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "br";
    xkbVariant = "";
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        accelProfile = "flat";
      };
    };
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    #jack.enable = true;
  };

  users = {
    users = {
      redyf = {
        isNormalUser = true;
        description = "redyf";
        initialPassword = "red123";
        shell = pkgs.zsh;
        extraGroups = ["networkmanager" "wheel" "input" "docker" "libvirtd"];
      };
    };
  };

  # Use doas instead-of sudo
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [
        {
          users = ["redyf"];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    playerctl
    xdg-desktop-portal-gtk
  ];

  xdg.mime = {
    enable = true;
    addedAssociations = {
      "application/pdf" = ["google-chrome-stable.desktop"];
      "video/mp4" = ["google-chrome-stable.desktop"];
      "x-scheme-handler/http" = ["google-chrome-stable.desktop"];
      "x-scheme-handler/https" = ["google-chrome-stable.desktop"];
      "text/html" = ["google-chrome-stable.desktop"];
    };
    defaultApplications = {
      "application/pdf" = ["google-chrome-stable.desktop"];
      "application/x-extension-htm" = ["google-chrome-stable.desktop"];
      "application/x-extension-html" = ["google-chrome-stable.desktop"];
      "application/x-extension-shtml" = ["google-chrome-stable.desktop"];
      "application/x-extension-xht" = ["google-chrome-stable.desktop"];
      "application/x-extension-xhtml" = ["google-chrome-stable.desktop"];
      "application/x-www-browser" = ["google-chrome-stable.desktop"];
      "application/xhtml+xml" = ["google-chrome-stable.desktop"];
      "text/html" = ["google-chrome-stable.desktop"];
      "x-scheme-handler/chrome" = ["google-chrome-stable.desktop"];
      "x-scheme-handler/http" = ["google-chrome-stable.desktop"];
      "x-scheme-handler/https" = ["google-chrome-stable.desktop"];
      "x-scheme-handler/ftp" = ["google-chrome-stable.desktop"];
      "x-scheme-handler/about" = ["google-chrome-stable.desktop"];
      "x-scheme-handler/unknown" = ["google-chrome-stable.desktop"];
      "x-scheme-handler/webcal" = ["google-chrome-stable.desktop"];
      "x-www-browser" = ["google-chrome-stable.desktop"];
      "video/mp4" = ["google-chrome-stable.desktop"];
      "browser" = ["google-chrome-stable.desktop"];
    };
  };

  environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.google-chrome}/bin/google-chrome-stable";

  # Enables flakes + garbage collector
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      auto-optimise-store = true;
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
