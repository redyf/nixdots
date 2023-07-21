{
  lib,
  config,
  pkgs,
  system,
  inputs,
  ...
}: {
  # Kernel Modules
  boot = {
    kernelModules = ["v4l2loopback"]; # Autostart kernel modules on boot
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback]; # loopback module to make OBS virtual camera work
    loader = {
      systemd-boot.enable = false;
      timeout = 10;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 3;

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

      theme = pkgs.fetchFromGitHub {
        owner = "shvchk";
        repo = "fallout-grub-theme";
        rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
        sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
      };

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
}
