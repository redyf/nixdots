{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    web.enable = lib.mkEnableOption "Enable web module";
  };
  config = lib.mkIf config.web.enable {
    home.packages = with pkgs; [
      vesktop
    ];
  };
}
