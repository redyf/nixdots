{
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf config.myHomeConfig.cli.tools.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
