{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    herdr.enable = lib.mkEnableOption "Enable herdr module";
  };
  config = lib.mkIf config.herdr.enable {
    home.packages = with pkgs; [
      herdr
    ];

    xdg.configFile."herdr/config.toml".source = ./config.toml;
  };
}
