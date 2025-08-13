{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.cli.zsh;
in
{
  config = lib.mkIf (config.myConfig.cli.enable && cfg.enable) {
    programs.zsh = {
      enable = true;
    };
  };
}
