{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    agents.enable = lib.mkEnableOption "Enable AI agents module";
  };

  config = lib.mkIf config.agents.enable {
    home.packages = [
      pkgs.gemini-cli-bin
      pkgs.codex
    ];
  };
}
