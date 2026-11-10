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
  options.myConfig.hardware.nvidia.enable = lib.mkEnableOption "NVIDIA drivers";

  config = lib.mkIf cfg.enable {
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
        package = config.boot.kernelPackages.nvidiaPackages.stable;
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
        __GL_NEXT_WAIT = "0";
        __GL_THREADED_OPTIMIZATION = "1";
        __GL_MaxFramesAllowed = "1";
        __GL_YIELD = "1";
        __GL_FSAA_MODE = "0";
        __GL_MIPMAP_HINT = "2";
        __GL_LOG_MAX_ANISO = "0";

        # Essencial para sincronia explícita em drivers novos (555+)
        NVD_BACKEND = "direct";

        # Garante que o Hyprland use a implementação correta da NVIDIA
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";

        CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      };
      shellAliases = {
        nvidia-settings = "nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings";
      };
    };
  };
}
