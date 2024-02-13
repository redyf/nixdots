{
  inputs,
  options,
  config,
  pkgs,
  lib,
  system,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.cli-apps.ripgrep;
in {
  options.cli-apps.ripgrep = with types; {
    enable = mkBoolOpt false "Enable or disable ripgrep";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.ripgrep = {
      enable = true;
    };
  };
}
