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
  cfg = config.cli-apps.jq;
in {
  options.cli-apps.jq = with types; {
    enable = mkBoolOpt false "Enable or disable jq";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.jq = {
      enable = true;
    };
  };
}
