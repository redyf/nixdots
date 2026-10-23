# Role: nvidia — NVIDIA GPU drivers plus nvibrant (digital vibrance).
# nvibrant's NixOS module is only imported here, so hosts without this role
# never see its options.
{
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
            hash = "sha256-WLf2GbV5lQLt0FS+diRSRbDhZ3OI/1x9QHEqBgJcRAA=";
          });
        };
      };
      srcs = lib.attrValues finalAttrs.passthru.srcAttrs;
    }
  );
in
{
  imports = [ inputs.nvibrant.nixosModules.default ];

  myConfig.hardware = {
    enable = lib.mkDefault true;
    nvidia.enable = lib.mkDefault true;
  };

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
}
