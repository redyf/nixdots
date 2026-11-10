{ pkgs, ... }:
{
  # Shared modules and profiles (roles) come from mkHost + meta.nix.
  imports = [ ./hardware-configuration.nix ];

  myConfig = {
    users = {
      description = "Desktop host";
      groups = {
        virtualisation = true;
        input = true;
      };
    };

    cli.appimage.enable = true;

    desktop = {
      i3.enable = true;
      xserver.displaySetup = "xrandr --output DP-0 --mode 1920x1080 --rate 165 --primary";
    };

    development.terraform.enable = true;

    gaming.gamescope.enable = true;

    services = {
      autorandr.enable = true;
      fstrim.enable = true;
    };

    system = {
      intel.enable = true;
      mime-types.enable = true;
      power-management.enable = true;
      sops = {
        enable = true;
        gitIdentity.enable = true;
      };
      tailscale.enable = true;
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
