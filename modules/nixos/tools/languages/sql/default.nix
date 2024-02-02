{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.sql;
in
{
  options.tools.languages.sql = with types; {
    enable = mkBoolOpt false "Enable sql";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        postgresql
        beekeeper-studio
      ];
    };
}
