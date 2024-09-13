{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    kvm.enable = lib.mkEnableOption "Enable kvm module";
  };
  config = lib.mkIf config.kvm.enable {
    home.packages = with pkgs; [
      virt-manager
    ];
  };
}
