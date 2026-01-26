{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    neve.enable = lib.mkEnableOption "Enable neve module";
  };
  config = lib.mkIf config.neve.enable {
    home.packages = [
      inputs.Neve.packages.${pkgs.stdenv.hostPackages.system}.default
    ];
  };
}
