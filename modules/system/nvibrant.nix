{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.nvibrant;
  nvibrantPackage = pkgs.nvibrant.overrideAttrs (
    finalAttrs: previousAttrs: {
      passthru = previousAttrs.passthru // {
        srcAttrs = previousAttrs.passthru.srcAttrs // {
          open-gpu = previousAttrs.passthru.srcAttrs.open-gpu.overrideAttrs (_: {
            hash = "sha256-vma87HifYp551b4SxfLGtSke4i4PvfNWnkufIXl8AW0=";
          });
        };
      };
      srcs = lib.attrValues finalAttrs.passthru.srcAttrs;
    }
  );
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    environment.systemPackages = [ nvibrantPackage ];

    services.nvibrant = {
      enable = true;
      package = nvibrantPackage;
      vibrancy = [
        "0%"
        "100%"
        "137%"
        "0%"
      ];
    };
  };
}
