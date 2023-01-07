# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";

boot.loader = {
    systemd-boot.enable = false;
    #timeout = 30;
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
    };
  };

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
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  
  # Enable Sway Enviroment.

  # services.xserver.displayManager.gdm = {
  #  enable = true;
  #  wayland = true;
  # };

  #programs.sway = {
  # 	enable = true;
  #	wrapperFeatures.gtk = true;
  #	extraPackages = with pkgs; [
  #	swaylock-fancy
  #	swaylock-effects
  #	dmenu
  #	waybar
  #	wofi
  #	grim
  #	slurp
  #	mako
  #	alacritty
#  ];
# };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.redyf = {
    isNormalUser = true;
    description = "redyf";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;
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
   # wget
  ];

programs.steam.enable = true;

  #fonts.fonts = with pkgs; [
  # (nerdfonts.override { fonts = [ "CascadiaCode" "JetBrainsMono" "FiraCode" "Hack" "Iosevka" ]; })
  #];

  #  Default Shell
     
  #   programs.zsh.enable = true;
  #  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
  enable = true;
  autosuggestions.enable = true;
  ohMyZsh.enable = true;
  ohMyZsh.plugins = [ 
  "git"
  "history-substring-search"
  "colored-man-pages"
  ];
  ohMyZsh.theme = "agnoster";
  syntaxHighlighting.enable = true;
  shellAliases = {
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

# Overlays
  nixpkgs.overlays = [
     (self: super: {
       discord = super.discord.overrideAttrs (
         _: { src = builtins.fetchTarball https://discord.com/api/download?platform=linux&format=tar.gz; }
       );
     })
  ];

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
