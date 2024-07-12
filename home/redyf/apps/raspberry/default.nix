{pkgs, ...}: {
  home.packages = with pkgs; [
    rpi-imager
    realvnc-vnc-viewer
  ];
}
