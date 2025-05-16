{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.programs.zsh;
in
{
  config = lib.mkIf (config.myConfig.programs.enable && cfg.enable) {
    programs.zsh = {
      enable = true;
    };
  };
}
