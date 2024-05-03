{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      dejavu_fonts
      font-awesome
      fira-code-symbols
      material-design-icons
      (nerdfonts.override {fonts = ["FiraMono" "JetBrainsMono" "LiberationMono"];})
      noto-fonts
      powerline-symbols
      monolisa-script
      # sf-mono-liga-bin
      # berkeley
      # geist-font
    ];
  };
}
