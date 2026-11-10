{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.development.obsidian.enable = lib.mkEnableOption "obsidian";
  config = lib.mkIf config.myHomeConfig.apps.development.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
