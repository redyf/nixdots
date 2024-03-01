{pkgs, ...}: {
  home.packages = with pkgs; [
    qemu-utils
    virt-manager
  ];
}
