{pkgs, ...}: {
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  home.packages = with pkgs; [
    virt-manager
  ];
}
