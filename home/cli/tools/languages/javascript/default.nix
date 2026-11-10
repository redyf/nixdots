{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.languages.javascript.enable = lib.mkEnableOption "javascript";
  config = lib.mkIf config.myHomeConfig.cli.tools.languages.javascript.enable {
    home.packages = with pkgs; [
      bun
      nodejs_latest
      corepack
    ];
  };
}
