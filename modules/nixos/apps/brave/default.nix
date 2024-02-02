{ options
, config
, pkgs
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.brave;
in
{
  options.apps.brave = with types; {
    enable = mkBoolOpt false "Enable or disable brave browser";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.brave ];
  };
}
