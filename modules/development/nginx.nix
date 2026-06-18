{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.development.nginx;
in
{
  config = lib.mkIf (config.myConfig.development.enable && cfg.enable) {
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
