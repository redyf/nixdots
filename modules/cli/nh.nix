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
  options.myConfig.cli.nh = {
    enable = lib.mkEnableOption "NH";
    flakePath = lib.mkOption {
      type = lib.types.str;
      default = "${homeDirectory}/opensource/nixdots";
      description = "Path to the flake used by nh.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };
      flake = cfg.flakePath;
    };
  };
}
