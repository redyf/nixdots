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
      kernelModules = [ "v4l2loopback" ]; # Autostart kernel modules on boot
      extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ]; # loopback module to make OBS virtual camera work
      kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
      supportedFilesystems = [ "ntfs" ];
      loader = {
        systemd-boot = {
          enable = lib.mkForce false;
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
          enable = false;
          # device = "nodev";
          # efiSupport = true;
          # useOSProber = true;
          # configurationLimit = 10;
          # theme = pkgs.fetchFromGitHub {
          #   owner = "Lxtharia";
          #   repo = "minegrub-theme";
          #   rev = "193b3a7c3d432f8c6af10adfb465b781091f56b3";
          #   sha256 = "1bvkfmjzbk7pfisvmyw5gjmcqj9dab7gwd5nmvi8gs4vk72bl2ap";
          # };
        };
      };
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };
    environment.systemPackages = [
      pkgs.sbctl
    ];
  };
}
