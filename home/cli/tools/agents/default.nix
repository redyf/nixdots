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
    home.packages = [
      pkgs.claude-code
      pkgs.mcp-nixos
    ];
  };
}
