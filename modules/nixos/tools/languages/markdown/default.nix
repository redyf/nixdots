{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.markdown;
in
{
  options.tools.languages.markdown = with types; {
    enable = mkBoolOpt false "Enable markdown";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        marksman
      ];
    };
}
