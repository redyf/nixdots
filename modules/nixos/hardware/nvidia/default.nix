{ options
, pkgs
, config
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.nvidia;
in
{
  options.hardware.nvidia = with types; {
    enable = mkBoolOpt false "Enable drivers and patches for Nvidia hardware.";
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
      nvidia = {
        open = false;
        nvidiaSettings = true;
        powerManagement.enable = true;
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
      opengl = {
        enable = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      };
    };

    environment = {
      variables = {
        GBM_BACKEND = "nvidia-drm";
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __GL_GSYNC_ALLOWED = "1";
        __GL_VRR_ALLOWED = "0"; # Controls if Adaptive Sync should be used. Recommended to set as “0” to avoid having problems on some games.
        XCURSOR_THEME = "macOS-BigSur";
        XCURSOR_SIZE = "32";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      };
      sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
        WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor rendering issue on wlr nvidia.
        DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox"; # Set default browser
      };
      shellAliases = { nvidia-settings = "nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings"; };
    };
  };
}
