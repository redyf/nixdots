{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      dejavu_fonts
      font-awesome
      fira-code-symbols
      material-design-icons
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      noto-fonts
      powerline-symbols
      monolisa-script
      # sf-mono-liga-bin
      # geist-font
    ];
  };
}
