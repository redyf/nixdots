{
  inputs,
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
    nixpkgs.overlays = [ inputs.claude-code.overlays.default ];
    home.packages =
      (with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
        claude-code
        opencode2
        pi
      ])
      ++ (with pkgs; [
        mcp-nixos
        rtk
        terraform-mcp-server
        ketch
      ]);
  };
}
