{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.Neve.packages.${system}.default
    stylua
    sumneko-lua-language-server
    ripgrep
  ];
}
