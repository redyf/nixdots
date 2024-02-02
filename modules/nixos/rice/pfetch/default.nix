{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.rice.pfetch;
in
{
  options.rice.pfetch = with types; {
    enable = mkBoolOpt false "Enable pfetch";
  };

  config =
    mkIf cfg.enable {
      environment = {
        systemPackages = with pkgs; [ pfetch ];
        sessionVariables.PF_INFO = "ascii title os kernel shell term desktop memory pkgs uptime scheme palette";
      };
    };
}
