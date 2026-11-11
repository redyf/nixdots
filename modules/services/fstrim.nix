{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.fstrim;
in
{
  options.myConfig.services.fstrim.enable = lib.mkEnableOption "fstrim";

  config = lib.mkIf cfg.enable {
    services = {
      fstrim.enable = true;
    };
  };
}
