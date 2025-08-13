{
  config,
  homeDirectory,
  lib,
  ...
}:

let
  cfg = config.myConfig.cli.nh;
in
{
  config = lib.mkIf (config.myConfig.cli.enable && cfg.enable) {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };
      flake = "${homeDirectory}/opensource/nixdots";
    };
  };
}
