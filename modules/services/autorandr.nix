{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.autorandr;
in
{
  # Monitor profiles are host-specific: set `services.autorandr.profiles` in
  # hosts/<name>/configuration.nix.
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services.autorandr.enable = true;
  };
}
