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
    nerdfonts
    noto-fonts
    dejavu_fonts
    font-awesome
    # ryan-mono-bin
    # ryan-term-bin
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
    nur.repos.sagikazarmark.sf-pro
    (nerdfonts.override {fonts = ["IBMPlexMono" "CascadiaCode" "FiraCode" "JetBrainsMono"];})
  ];
}
