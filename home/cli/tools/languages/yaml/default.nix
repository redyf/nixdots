{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.languages.yaml.enable = lib.mkEnableOption "yaml";
  config = lib.mkIf config.myHomeConfig.cli.tools.languages.yaml.enable {
    home.packages = with pkgs; [
      yaml-language-server
    ];
  };
}
