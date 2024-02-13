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
  cfg = config.cli-apps.rm-improved;
in {
  options.cli-apps.rm-improved = with types; {
    enable = mkBoolOpt false "Enable or disable rm-improved";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [rm-improved];
  };
}
