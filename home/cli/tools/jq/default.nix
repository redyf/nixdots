{
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.jq.enable = lib.mkEnableOption "jq";
  config = lib.mkIf config.myHomeConfig.cli.tools.jq.enable {
    programs.jq = {
      enable = true;
    };
  };
}
