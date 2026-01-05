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
        open = false;
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
        # __GL_VRR_ALLOWED = "0"; # Controls if Adaptive Sync should be used. Recommended to set as “0” to avoid having problems on some games.
        # 1. Desabilita o V-Sync do Driver (IMPORTANTE)
        # __GL_SYNC_TO_VBLANK = "0";

        # 2. Desabilita o Triple Buffering do Driver (Latência)
        __GL_NEXT_WAIT = "0";

        # 3. Força o modo de threads (Low Latency Mode/LLM)
        __GL_THREADED_OPTIMIZATION = "1";
        __GL_MaxFramesAllowed = "1"; # Fila de renderização = 1

        # 4. Outras otimizações (se não houver problemas, mantenha '1')
        __GL_YIELD = "1";

        # Desativa o Anti-Aliasing (FSAA).
        __GL_FSAA_MODE = "0";

        # Prioriza o Desempenho no Mipmapping.
        __GL_MIPMAP_HINT = "2";

        # Desativa a Filtragem Anisotrópica (AF).
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
