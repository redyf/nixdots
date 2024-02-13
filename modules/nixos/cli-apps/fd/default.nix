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
  cfg = config.cli-apps.fd;
in {
  options.cli-apps.fd = with types; {
    enable = mkBoolOpt false "Enable or disable fd";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [fd];
  };
}
