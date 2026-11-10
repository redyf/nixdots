{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.cymbal.enable = lib.mkEnableOption "cymbal";
  config = lib.mkIf config.myHomeConfig.cli.tools.cymbal.enable {
    home.packages = [ pkgs.cymbal ];
  };
}
