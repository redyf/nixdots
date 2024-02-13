{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.rice.nitch;
in
{
  options.rice.nitch = with types; {
    enable = mkBoolOpt false "Enable Nitch";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.nitch ];
  };
}
