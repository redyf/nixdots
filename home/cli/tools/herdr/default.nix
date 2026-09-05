{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    herdr.enable = lib.mkEnableOption "Enable herdr module";
  };
  config = lib.mkIf config.herdr.enable {
    home.packages = [
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr
    ];

    xdg.configFile."herdr/config.toml".source = ./config.toml;
  };
}
