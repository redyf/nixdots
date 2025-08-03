{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.ssh;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    services = {
      openssh = {
        enable = true;
        settings.PermitRootLogin = "yes";
      };
    };
  };
}
