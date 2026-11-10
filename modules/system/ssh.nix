{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.ssh;
in
{
  options.myConfig.system.ssh.enable = lib.mkEnableOption "ssh";

  config = lib.mkIf cfg.enable {
    services = {
      openssh = {
        enable = true;
        settings.PermitRootLogin = "no";
      };
    };
  };
}
