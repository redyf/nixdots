{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.languages.c.enable = lib.mkEnableOption "C";
  config = lib.mkIf config.myHomeConfig.cli.tools.languages.c.enable {
    home.packages = with pkgs; [
      gcc
      gnumake
    ];
  };
}
