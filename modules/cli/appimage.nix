{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.cli.appimage;
in
{
  config = lib.mkIf (config.myConfig.cli.enable && cfg.enable) {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
