{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.fd.enable = lib.mkEnableOption "fd";
  config = lib.mkIf config.myHomeConfig.cli.tools.fd.enable {
    home.packages = with pkgs; [ fd ];
  };
}
