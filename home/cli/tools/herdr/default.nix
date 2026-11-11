{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.herdr.enable = lib.mkEnableOption "herdr";
  config = lib.mkIf config.myHomeConfig.cli.tools.herdr.enable {
    home.packages = [
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr
    ];

    xdg.configFile."herdr/config.toml".source = ./config.toml;
  };
}
