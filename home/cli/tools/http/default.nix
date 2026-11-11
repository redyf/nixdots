{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.http.enable = lib.mkEnableOption "http";
  config = lib.mkIf config.myHomeConfig.cli.tools.http.enable {
    home.packages = with pkgs; [
      curl
      openssl
    ];
  };
}
