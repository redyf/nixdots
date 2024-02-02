{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.cli-apps.helix;
in
{
  options.cli-apps.helix = with types; {
    enable = mkBoolOpt false "Enable or disable Helix";
  };

  config =
    mkIf cfg.enable {
      home.extraOptions.programs.helix = {
        enable = true;
        catppuccin.enable = true;
        defaultEditor = true;
      };
    };
}
