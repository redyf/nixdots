{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      font-manager
      dejavu_fonts
      font-awesome
      fira-code-symbols
      (iosevka-bin.override {variant = "aile";})
      material-design-icons
      # monolisa
      monolisa-script
      (nerdfonts.override {fonts = ["FiraMono" "JetBrainsMono"];})
      noto-fonts
      powerline-symbols
      # sf-mono-liga-bin
    ];
  };
}
