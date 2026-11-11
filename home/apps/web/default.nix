{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.web.enable = lib.mkEnableOption "web";
  config = lib.mkIf config.myHomeConfig.apps.web.enable {
    home.packages = with pkgs; [
      discord
      slack
      openvpn
      pritunl-client
      dig
      cloudflared
    ];
  };
}
