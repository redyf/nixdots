{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options.myHomeConfig.cli.tools.agents.orchestrators.enable =
    lib.mkEnableOption "AI agent orchestrators";

  config = lib.mkIf config.myHomeConfig.cli.tools.agents.orchestrators.enable {
    home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      orca
      t3code-desktop
    ];
  };
}
