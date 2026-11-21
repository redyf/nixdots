{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options.myHomeConfig.cli.tools.agents.clients.enable = lib.mkEnableOption "AI clients";

  config = lib.mkIf config.myHomeConfig.cli.tools.agents.clients.enable {
    home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      claude-desktop
    ];
  };
}
