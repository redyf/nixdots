{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    yaml.enable = lib.mkEnableOption "Enable yaml module";
  };
  config = lib.mkIf config.yaml.enable {
    home.packages = with pkgs; [
      yaml-language-server
    ];
  };
}
