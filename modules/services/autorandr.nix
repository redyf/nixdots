{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.autorandr;
in
{
  options.myConfig.services.autorandr.enable = lib.mkEnableOption "autorandr";

  # Monitor profiles are host-specific: set `services.autorandr.profiles` in
  # hosts/<name>/configuration.nix.
  config = lib.mkIf cfg.enable {
    services.autorandr.enable = true;
  };
}
