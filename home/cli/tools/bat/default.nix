{
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.bat.enable = lib.mkEnableOption "bat";
  config = lib.mkIf config.myHomeConfig.cli.tools.bat.enable {
    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };
  };
}
