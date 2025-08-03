{
  inputs,
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
        extraPackages = [ pkgs.nvidia-vaapi-driver ];
      };
    };
    environment = {
      variables = {
        LIBVA_DRIVER_NAME = "nvidia";
        XDG_SESSION_TYPE = "wayland";
        GBM_BACKEND = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __GL_GSYNC_ALLOWED = "1";
        __GL_VRR_ALLOWED = "0"; # Controls if Adaptive Sync should be used. Recommended to set as “0” to avoid having problems on some games.
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      };
      shellAliases = {
        nvidia-settings = "nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings";
      };
    };
  };
}
