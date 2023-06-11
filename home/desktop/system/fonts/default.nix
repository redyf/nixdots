{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Fonts
    go-font
    nerdfonts
    noto-fonts
    dejavu_fonts
    font-awesome
    maple-mono-NF
    liberation_ttf
    powerline-fonts
    cantarell-fonts
    source-code-pro
    fira-code-symbols
    powerline-symbols
    material-design-icons
    (nerdfonts.override {fonts = ["IBMPlexMono" "CascadiaCode" "FiraCode" "JetBrainsMono" "Iosevka"];})
  ];
}
