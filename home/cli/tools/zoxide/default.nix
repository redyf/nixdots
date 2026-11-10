{
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.zoxide.enable = lib.mkEnableOption "zoxide";
  config = lib.mkIf config.myHomeConfig.cli.tools.zoxide.enable {
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
