{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.insomnia;
in
{
  options.apps.insomnia = with types; {
    enable = mkBoolOpt false "Enable Insomnia client";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        custom.insomnia
      ];
    };
}
