{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Fonts
    go-font
    nerdfix # Helps you find/fix obsolete Nerd font icons
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
    nur.repos.oluceps.san-francisco
    # inputs.sf-mono-liga-src.packages.${pkgs.system}.SFMono-Nerd-Font-Ligaturized

    (nerdfonts.override {fonts = ["IBMPlexMono" "CascadiaCode" "Terminus" "FiraCode" "JetBrainsMono" "Iosevka"];})
  ];
}
