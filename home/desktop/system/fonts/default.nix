{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Fonts
    # go-font
    apl386
    nerdfonts
    noto-fonts
    dejavu_fonts
    font-awesome
    # maple-mono-NF
    # courier-prime
    liberation_ttf # Needed to make vanilla st terminal work
    # powerline-fonts
    # cantarell-fonts
    # source-code-pro
    fira-code-symbols
    powerline-symbols
    material-design-icons
    # helvetica-neue-lt-std
    (nerdfonts.override {fonts = ["IBMPlexMono" "CascadiaCode" "FiraCode" "JetBrainsMono" "LiberationMono" "SourceCodePro"];})
  ];
}
