{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.dart;
in
{
  options.tools.languages.dart = with types; {
    enable = mkBoolOpt false "Enable dart";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        dart
      ];
    };
}
