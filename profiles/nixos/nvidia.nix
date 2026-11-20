# Role: nvidia — NVIDIA GPU drivers plus nvibrant (digital vibrance).
# nvibrant's NixOS module is only imported here, so hosts without this role
# never see its options.
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  nvibrantPackage = pkgs.nvibrant.overrideAttrs (
    finalAttrs: previousAttrs: {
      passthru = previousAttrs.passthru // {
        srcAttrs = previousAttrs.passthru.srcAttrs // {
          open-gpu = previousAttrs.passthru.srcAttrs.open-gpu.overrideAttrs (_: {
            hash = "sha256-nAYbuLLS5RtIEydpgVr/1UnMzn+WnoiHjdVzIISnIC4=";
          });
        };
      };
      srcs = lib.attrValues finalAttrs.passthru.srcAttrs;
    }
  );
in
{
  imports = [ inputs.nvibrant.nixosModules.default ];

  config = lib.mkMerge [
    # Toggle the whole GPU stack (drivers + nvibrant) from the host with
    # myConfig.hardware.nvidia.enable = false; the role stays in meta.nix.
    { myConfig.hardware.nvidia.enable = lib.mkDefault true; }

    (lib.mkIf config.myConfig.hardware.nvidia.enable {
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
    })
  ];
}
