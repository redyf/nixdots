{pkgs, ...}: {
  home.packages = with pkgs; [
    nerdfix # Fix obsolete nerd font icons
    noto-fonts
    dejavu_fonts
    font-awesome
    fira-code-symbols
    powerline-symbols
    material-design-icons
    (nerdfonts.override {fonts = ["IBMPlexMono" "CascadiaCode" "FiraCode" "FiraMono" "JetBrainsMono" "IntelOneMono"];})
  ];
}
