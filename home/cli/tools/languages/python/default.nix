{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.languages.python.enable = lib.mkEnableOption "python";
  config = lib.mkIf config.myHomeConfig.cli.tools.languages.python.enable {
    home.packages = with pkgs; [
      python3
      uv
    ];
  };
}
