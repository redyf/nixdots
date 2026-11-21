{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options.myHomeConfig.cli.tools.agents.harnesses.enable =
    lib.mkEnableOption "AI coding agent harnesses";

  config = lib.mkIf config.myHomeConfig.cli.tools.agents.harnesses.enable {
    home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      claude-code
      opencode2
      pi
      dsh
    ];
  };
}
