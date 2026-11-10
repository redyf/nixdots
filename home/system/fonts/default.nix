{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
{
  options.myHomeConfig.system.fonts.enable = lib.mkEnableOption "fonts";
  config = lib.mkIf config.myHomeConfig.system.fonts.enable {
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
