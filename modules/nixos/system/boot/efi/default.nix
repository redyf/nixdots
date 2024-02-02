{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.system.boot.efi;
in
{
  options.system.boot.efi = with types; {
    enable = mkBoolOpt false "Wheter or not to enable booting";
  };

  config =
    mkIf cfg.enable {
      boot = {
        kernelModules = [ "v4l2loopback" ]; # Autostart kernel modules on boot
        extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ]; # loopback module to make OBS virtual camera work
        supportedFilesystems = [ "ntfs" ];
        loader = {
          systemd-boot = {
            enable = true;
            # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
            editor = false;
          };
          timeout = 10;
          efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
          };
        };
      };
    };
}
