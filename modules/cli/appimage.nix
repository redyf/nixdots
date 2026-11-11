{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.cli.appimage;
in
{
  options.myConfig.cli.appimage.enable = lib.mkEnableOption "appimage-run";

  config = lib.mkIf cfg.enable {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
