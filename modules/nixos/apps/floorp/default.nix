{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.floorp;
in
{
  options.apps.floorp = with types; {
    enable = mkBoolOpt false "Enable or disable floorp browser";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ floorp ];
    };
}
