{
  pkgs,
  config,
  lib,
  nix-cachyos-kernel,
  ...
}:

let
  cfg = config.myConfig.system.cachy;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
    boot = {
      kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
      kernelParams = [ "preempt=full" ];
    };
  };
}
