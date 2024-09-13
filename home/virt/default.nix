{
  lib,
  config,
  ...
}:
{
  imports = [
    ./kvm
  ];

  options = {
    virt.enable = lib.mkEnableOption "Enable virtualization module";
  };
  config = lib.mkIf config.virt.enable {
    kvm.enable = lib.mkDefault false;
  };
}
