{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  cfg = config.myConfig.system.cachy;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
    boot = {
      kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
      kernelParams = [ "preempt=full" ];
    };
  };
}
