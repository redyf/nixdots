{ pkgs, ... }: {
  home.packages = with pkgs; [
    element-desktop-wayland
  ];
}
