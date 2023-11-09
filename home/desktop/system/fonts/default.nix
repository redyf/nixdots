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
    # apl386
    noto-fonts
    dejavu_fonts
    font-awesome
    # courier-prime
    # powerline-fonts
    # cantarell-fonts
    fira-code-symbols
    powerline-symbols
    material-design-icons
    # helvetica-neue-lt-std
    (nerdfonts.override {fonts = ["IBMPlexMono" "CascadiaCode" "FiraCode" "JetBrainsMono" "SourceCodePro"];})
  ];
}
