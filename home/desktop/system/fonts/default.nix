{
  inputs,
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      font-manager
      dejavu_fonts
      font-awesome
      fira-code-symbols
      (iosevka-bin.override {variant = "aile";})
      material-design-icons
      Monolisa
      (nerdfonts.override {fonts = ["FiraMono" "JetBrainsMono"];})
      noto-fonts
      powerline-symbols
      # sf-mono-liga-bin
    ];
  };
  # fonts = {
  #   enableDefaultPackages = true;
  #   fontconfig = {
  #     enable = true;
  #     defaultFonts = {
  #       serif = ["Iosevka Aile, Times, Noto Serif"];
  #       sansSerif = ["Iosevka Aile, Helvetica Neue LT Std, Helvetica, Noto Sans"];
  #       monospace = ["Courier Prime, Courier, Noto Sans Mono"];
  #     };
  #   };
  # packages = with pkgs; [
  #   dejavu_fonts
  #   font-awesome
  #   fira-code-symbols
  #   (iosevka-bin.override {variant = "aile";})
  #   material-design-icons
  #   # Monolisa
  #   (nerdfonts.override {fonts = ["FiraMono" "JetBrainsMono"];})
  #   noto-fonts
  #   powerline-symbols
  #   # sf-mono-liga-bin
  # ];
}
