{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    api-client.enable = lib.mkEnableOption "Enable api-client module";
  };
  config = lib.mkIf config.api-client.enable {
    home.packages = with pkgs; [
      postman
    ];
  };
}
