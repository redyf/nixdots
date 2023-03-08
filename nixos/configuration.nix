# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  final,
  prev,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.loader = {
    systemd-boot.enable = false;
    timeout = 20;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 5;
      # theme = pkgs.fetchFromGitHub {
      #   owner = "shvchk";
      #   repo = "fallout-grub-theme";
      #   rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
      #   sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
      # };
      #   theme = (pkgs.fetchFromGitHub
      #     {
      #       owner = "catppuccin";
      #       repo = "grub";
      #       rev = "803c5df0e83aba61668777bb96d90ab8f6847106";
      #       sha256 = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
      #     } + "/src/catppuccin-mocha-grub-theme");
      # };
      # theme = (pkgs.fetchFromGitHub
      #   {
      #     owner = "OliveThePuffin";
      #     repo = "yorha-grub-theme";
      #     rev = "4d9cd37baf56c4f5510cc4ff61be278f11077c81";
      #     sha256 = "0r6i95wbc5v7b50chy0lmfjrhf6akbm68y6ipm1hzvac087xhp2x";
      #   } + "/yorha-1920x1080");
      # theme = pkgs.fetchFromGitHub
      #   {
      #     owner = "Lxtharia";
      #     repo = "minegrub-theme";
      #     rev = "193b3a7c3d432f8c6af10adfb465b781091f56b3";
      #     sha256 = "1bvkfmjzbk7pfisvmyw5gjmcqj9dab7gwd5nmvi8gs4vk72bl2ap";
      #   };
      theme =
        pkgs.fetchFromGitHub
        {
          owner = "Patato777";
          repo = "dotfiles";
          rev = "d6f96fa59327a936d335f01a7295815250f96ff7";
          sha256 = "18mra67kd20bld5zxlvb89ik8psr2pj0v9iaizqpd485sywgqwiq";
        }
        + "/grub/themes/virtuaverse";
    };
  };

  # (final: prev: {
  #   sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
  #     pname = "sf-mono-liga-bin";
  #     version = "dev";
  #     src = inputs.sf-mono-liga-src;
  #     dontConfigure = true;
  #     installPhase = ''
  #       mkdir -p $out/share/fonts/opentype
  #       cp -R $src/*.otf $out/share/fonts/opentype/
  #     '';
  #   };
  # });

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.bspwm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
    nvidiaPatches = true;
  };

  programs.haguichi.enable = true;
  services.logmein-hamachi.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.xserver.videoDrivers = ["nvidia"];

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.sessionVariables = {
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

      # disabling touchpad acceleration
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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.redyf = {
    isNormalUser = true;
    description = "redyf";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "input"];
  };

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #     sha256 = "16advd3xbwxd705n9ngs6npg0bwgvqmdfg4g80nbisimw3h5ww3v";
  #   }))
  # ];

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # vim
    # git
    zsh
    oh-my-zsh
    zsh-syntax-highlighting
    zsh-z
    fzf
    xdg-desktop-portal-gtk
    # wget
  ];

  programs.steam.enable = true;

  # fonts = {
  #    fonts = with pkgs; [
  #      inter
  #       sf-mono-liga-bin
  #      material-symbols
  #      noto-fonts
  #      noto-fonts-cjk
  #      noto-fonts-emoji
  #    ];
  #    fontconfig = {
  #      enable = true;
  #      antialias = true;
  #      hinting = {
  #        enable = true;
  #        autohint = true;
  #        style = "hintfull";
  #      };

  #      subpixel.lcdfilter = "default";

  #      defaultFonts = {
  #        emoji = ["Noto Color Emoji"];
  #        monospace = ["SFLiga Mono Nerd Font"];
  #        sansSerif = ["Noto Sans" "Noto Color Emoji"];
  #        serif = ["Noto Serif" "Noto Color Emoji"];
  #      };
  #    };
  # };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [
      "git"
      "history-substring-search"
      "colored-man-pages"
    ];
    ohMyZsh.theme = "bira";
    syntaxHighlighting.enable = true;
    # autosuggestions.highlightStyle = "fg=#E9729D";
    shellAliases = {
      e = "emacsclient -c -a 'emacs'";
      f = "pfetch";
      v = "lvim";
      nv = "lvimn";
      ll = "ls -l";
      ls = "exa";
      la = "exa -a";
      grep = "grep --color=auto";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      g = "git";
      gs = "git status";
      dotDir = "~/.config/zsh";
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
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
