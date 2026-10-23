{
  config,
  pkgs,
  ...
}:
{
  # Shared modules and profiles (roles) come from mkHost + meta.nix.
  imports = [ ./hardware-configuration.nix ];

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
      isNormalUser = true;
      description = "Desktop host"; # Optional - defaults to username if not specified
      hashedPasswordFile = config.sops.secrets."users/${config.myConfig.users.username}/password".path;
      shell = pkgs.zsh;

      groups = {
        # development = true;
        virtualisation = true;
        # media = true;
        input = true;
      };
    };

    cli = {
      appimage.enable = true;
    };

    desktop = {
      gnome.enable = false;
      i3.enable = true;
      kde.enable = false;
      sway.enable = false;
      # NOTE: autorandr below uses 180 Hz for the same output.
      xserver.displaySetup = "xrandr --output DP-0 --mode 1920x1080 --rate 165 --primary";
    };

    development = {
      localstack.enable = true;
      terraform.enable = true;
    };

    gaming = {
      gamescope.enable = true;
    };

    services = {
      autorandr.enable = true;
      fstrim.enable = true;
      jackett.enable = false;
    };

    system = {
      ananicy.enable = false;
      cachy.enable = false;
      intel.enable = true;
      kernel.enable = false;
      mime-types.enable = true;
      power-management.enable = true;
      sops = {
        enable = true;
        gitIdentity.enable = true;
      };
      tailscale.enable = false;
    };
  };

  # Encrypt work data and credentials at rest; unlocked by the login password.
  security.pam.enableFscrypt = true;

  environment.systemPackages = with pkgs; [
    fscrypt-experimental
    mongodb
    mongosh
    mongodb-tools
    pulseaudio
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      curl
    ];
  };

  services.autorandr.profiles.redyf.config.DP-0 = {
    enable = true;
    primary = true;
    mode = "1920x1080";
    rate = "180.00";
    position = "0x0";
  };

  system.stateVersion = "25.05"; # Don't change this
}
