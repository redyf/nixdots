{pkgs, ...}: {
  home.packages = with pkgs; [
    bemenu
  ];
}
