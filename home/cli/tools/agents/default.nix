{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  llmAgents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.myHomeConfig.cli.tools.agents.enable = lib.mkEnableOption "AI agents";

  config = lib.mkIf config.myHomeConfig.cli.tools.agents.enable {
    home.packages =
      (with llmAgents; [
        claude-code
        claude-desktop
        opencode2
        pi
        herdr
      ])
      ++ (with pkgs; [
        terraform-mcp-server
        ketch
      ]);
  };
}
