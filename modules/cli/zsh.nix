{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.cli.zsh;
in
{
  options.myConfig.cli.zsh.enable = lib.mkEnableOption "Zsh";

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
    };
  };
}
