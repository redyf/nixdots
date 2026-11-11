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
  options.myConfig.system.boot.enable = lib.mkEnableOption "boot";

  config = lib.mkIf cfg.enable {
    boot = {
      kernelModules = [
        "v4l2loopback"
      ];
      extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ]; # loopback module to make OBS virtual camera work
      supportedFilesystems = [ "ntfs" ];
      loader = {
        timeout = 10;
        efi = {
          canTouchEfiVariables = true;
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
    };
    environment.systemPackages = [
      pkgs.sbctl
      pkgs.os-prober
      pkgs.efibootmgr
    ];
  };
}
