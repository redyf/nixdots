{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.virtualization.virtmanager;
in
{
  options.myConfig.virtualization.virtmanager.enable = lib.mkEnableOption "VirtManager";

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
      };
    };
  };
}
