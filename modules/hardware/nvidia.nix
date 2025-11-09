{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.hardware.nvidia;
in
{
  config = lib.mkIf (config.myConfig.hardware.enable && cfg.enable) {
    boot.kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia_drm.fbdev=1"
    ];

    services = {
      xserver = {
        videoDrivers = [ "nvidia" ];
      };
    };

    hardware = {
      nvidia = {
        open = true;
        nvidiaSettings = true;
        powerManagement.enable = true;
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];
      };
    };
    environment = {
      variables = {
        __GL_GSYNC_ALLOWED = "1";
        __GL_VRR_ALLOWED = "0"; # Controls if Adaptive Sync should be used. Recommended to set as “0” to avoid having problems on some games.
        CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      };
      shellAliases = {
        nvidia-settings = "nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings";
      };
    };
  };
}
