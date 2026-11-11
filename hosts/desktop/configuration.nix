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
      # Same layout as hosts/desktop/home.nix (X11 names the HDMI-A-2 connector HDMI-2).
      xserver.displaySetup = "xrandr --output DP-1 --mode 1920x1080 --rate 180 --primary --output HDMI-2 --mode 1920x1080 --rate 119.98 --right-of DP-1 --rotate left";
    };

    development.terraform.enable = true;

    gaming.gamescope.enable = true;

    services = {
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

  system.stateVersion = "25.05"; # Don't change this
}
