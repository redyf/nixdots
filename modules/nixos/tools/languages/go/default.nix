{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.go;
in
{
  options.tools.languages.go = with types; {
    enable = mkBoolOpt false "Enable golang";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ go gopls ];
    };
}
