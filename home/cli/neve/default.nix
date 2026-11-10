{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.neve.enable = lib.mkEnableOption "neve";
  config = lib.mkIf config.myHomeConfig.cli.neve.enable {
    home.packages = [
      inputs.Neve.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
