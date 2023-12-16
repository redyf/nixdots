{pkgs, ...}: {
  home.packages = with pkgs; [
    noto-fonts
    dejavu_fonts
    font-awesome
    fira-code-symbols
    powerline-symbols
    material-design-icons
    (nerdfonts.override {fonts = ["IBMPlexMono" "CascadiaCode" "FiraCode" "JetBrainsMono" "IntelOneMono"];})
  ];
}
