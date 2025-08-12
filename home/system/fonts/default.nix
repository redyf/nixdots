{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    fonts.enable = lib.mkEnableOption "Enable fonts module";
  };
  config = lib.mkIf config.fonts.enable {
    home = {
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        inputs.font-flake.packages.${system}.tx02
      ];
    };
  };
}
