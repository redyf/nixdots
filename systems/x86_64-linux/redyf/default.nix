{
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  suites = {
    common = enabled;
    desktop = enabled;
    development = enabled;
    music = enabled;
    video = enabled;
    social = enabled;
    gaming = disabled;
    rice = enabled;
  };

  programs.hyprland = {
    enable = true;
  };

  # Change systemd stop job timeout in NixOS configuration (Default = 90s)
  systemd = {
    services.NetworkManager-wait-online.enable = false;
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  # Configure keymap in X11
  services = {
    # Enable CUPS to print documents.
    # printing.enable = true;
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
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
    logmein-hamachi.enable = false;
    flatpak.enable = false;
  };

  environment.systemPackages = with pkgs; [
    git
    playerctl
    deploy-rs
  ];

  system.stateVersion = "22.11"; # Did you read the comment?
}
