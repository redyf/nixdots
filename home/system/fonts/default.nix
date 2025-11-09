{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  hasFontAccess =
    inputs ? font-flake && inputs.font-flake ? packages && inputs.font-flake.packages ? ${pkgs.system};
in
{
  options = {
    fonts.enable = lib.mkEnableOption "Enable fonts module";
  };
  config = lib.mkIf config.fonts.enable {
    home.packages =
      with pkgs;
      [
        nerd-fonts.jetbrains-mono
        maple-mono.NF
      ]
      ++ lib.optionals hasFontAccess [
        inputs.font-flake.packages.${pkgs.system}.tx02
      ];
  };
}
