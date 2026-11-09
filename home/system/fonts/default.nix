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
        inputs.font-flake.packages.${stdenv.hostPlatform.system}.monolisa
        inputs.font-flake.packages.${stdenv.hostPlatform.system}.tx02
        inputs.font-flake.packages.${stdenv.hostPlatform.system}.berkeley-mono
        nerd-fonts.jetbrains-mono
      ];
    };
  };
}
