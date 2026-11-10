{
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.ripgrep.enable = lib.mkEnableOption "ripgrep";
  config = lib.mkIf config.myHomeConfig.cli.tools.ripgrep.enable {
    programs.ripgrep = {
      enable = true;
    };
  };
}
