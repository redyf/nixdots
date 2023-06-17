{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    nerdfonts
    noto-fonts
    font-awesome
    maple-mono-NF
    fira-code-symbols
    powerline-symbols
    material-design-icons
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];
}
