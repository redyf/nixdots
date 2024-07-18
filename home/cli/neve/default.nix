{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    neve.enable = lib.mkEnableOption "Enable neve module";
  };
  config = lib.mkIf config.neve.enable {
    home.packages = with pkgs; [
      inputs.Neve.packages.${system}.default
      stylua
      sumneko-lua-language-server
      ripgrep
    ];
  };
}
