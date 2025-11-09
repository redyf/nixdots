{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.boot;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    boot = {
      kernelModules = [
        "v4l2loopback"
      ];
      extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ]; # loopback module to make OBS virtual camera work
      # kernelParams = [
      #   "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      #   "nvidia_drm.fbdev=1"
      # ];
      supportedFilesystems = [ "ntfs" ];
      loader = {
        systemd-boot = {
          enable = false;
          # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
          editor = false;
          configurationLimit = 10;
          # extraEntries = {
          #   "windows.conf" = ''
          #     title Windows 10
          #     efi /EFI/Microsoft/Boot/bootmgfw.efi
          #   '';
          # };
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
            pkgs.fetchFromGitHub {
              owner = "Lxtharia";
              repo = "minegrub-theme";
              rev = "040b163268be6e7cf743ba990177525dc47ed944";
              sha256 = "0fc0ypaha22vv79izc1r2w3sb12ky256v31rs5lrhzrg002b3ibd";
            }
            + "/minegrub";
        };
      };
      # lanzaboote = {
      #   enable = true;
      #   pkiBundle = "/var/lib/sbctl";
      # };
    };
    environment.systemPackages = [
      pkgs.sbctl
      pkgs.os-prober
      pkgs.efibootmgr
    ];
  };
}
