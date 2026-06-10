{
  config,
  inputs,
  lib,
  pkgs,
  username,
  homeDirectory,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/nixos/base.nix
    ../../modules
  ];

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
      username = "redyf";
      isNormalUser = true;
      description = "Desktop host"; # Optional - defaults to username if not specified
      hashedPasswordFile = config.sops.secrets."users/redyf/password".path;
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
    };

    development = {
      localstack.enable = true;
      terraform.enable = true;
    };

    gaming = {
      gamescope.enable = true;
    };

    hardware = {
      enable = true;
      nvidia.enable = true;
    };

    services = {
      fstrim.enable = true;
      jackett.enable = false;
    };

    system = {
      ananicy.enable = false;
      cachy.enable = false;
      intel.enable = true;
      kernel.enable = false;
      mime-types.enable = true;
      nvibrant.enable = true;
      power-management.enable = true;
      sops.enable = true;
      tailscale.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    mongodb
    mongosh
    mongodb-tools
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
