{ pkgs, ... }: {
  home.packages = with pkgs; [
    noto-fonts
    dejavu_fonts
    font-awesome
    fira-code-symbols
    powerline-symbols
    material-design-icons
    commit-mono
    (nerdfonts.override { fonts = [ "IBMPlexMono" "CascadiaCode" "FiraCode" "FiraMono" "JetBrainsMono" "IntelOneMono" "Ubuntu" ]; })
  ];
}
