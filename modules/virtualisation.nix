{ pkgs, ... }:
{
  # Enables docker in rootless mode
  virtualisation = {
    docker.enable = true;
    # docker.rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
    # Enables virtualization for virt-manager
    libvirtd.enable = true;
  };
}
