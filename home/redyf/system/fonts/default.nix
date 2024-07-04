{
  inputs,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      dejavu_fonts
      font-awesome
      fira-code-symbols
      material-design-icons
      noto-fonts
      powerline-symbols
      # monolisa-script
      # berkeley
      # sf-mono-liga-bin
    ];
  };
}
