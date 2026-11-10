{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.jackett;
in
{
  options.myConfig.services.jackett.enable = lib.mkEnableOption "jackett";

  config = lib.mkIf cfg.enable {
    services = {
      jackett = {
        enable = true;
      };
    };
  };
}
