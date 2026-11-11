{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.development.nginx;
in
{
  options.myConfig.development.nginx.enable = lib.mkEnableOption "Nginx";

  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      virtualHosts."localhost" = {
        listen = [
          {
            addr = "127.0.0.1";
            port = 8080;
          }
        ];
        root = "/var/www/html";
        locations."/" = {
          tryFiles = "$uri $uri/ =404";
        };
      };
    };
  };
}
