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
  options = {
    agents.enable = lib.mkEnableOption "Enable AI agents module";
  };

  config = lib.mkIf config.agents.enable {
    home.packages =
      (with llmAgents; [
        claude-code
        claude-desktop
        opencode2
        pi
      ])
      ++ (with pkgs; [
        # mcp-nixos: broken in nixpkgs (fastmcp-slim needs mcp < 2); re-add once fixed
        rtk
        terraform-mcp-server
        ketch
      ]);
  };
}
