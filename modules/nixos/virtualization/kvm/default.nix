{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.virtualization.kvm;
in
{
  options.virtualization.kvm = with types; {
    enable = mkBoolOpt false "Enable virtualization";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      virt-manager
    ];
    # Enables docker in rootless mode
    virtualisation = {
      docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
      # Enables virtualization for virt-manager
      libvirtd.enable = true;
    };
  };
}
