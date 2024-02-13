{ inputs
, options
, config
, pkgs
, lib
, system
, ...
}:
with lib;
with lib.custom; let
  cfg = config.cli-apps.eza;
in
{
  options.cli-apps.eza = with types; {
    enable = mkBoolOpt false "Enable or disable eza";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.eza = {
      enable = true;
      icons = true;
      enableAliases = true;
    };
  };
}
