{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.python;
in
{
  options.tools.languages.python = with types; {
    enable = mkBoolOpt false "Enable python";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        poetry
        (python311.withPackages (ps:
          with ps; [
            black # Python formatter
            pynvim
            flake8 # Linter for Python
          ]))
      ];
    };
}
