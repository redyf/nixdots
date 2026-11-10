{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.system.kernel;
in
{
  options.myConfig.system.kernel.enable =
    lib.mkEnableOption "the stock nixpkgs kernel (ZFS would otherwise pick its own)";

  config = lib.mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages;
  };
}
