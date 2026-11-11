{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.development.vscode.enable = lib.mkEnableOption "vscode";
  config = lib.mkIf config.myHomeConfig.apps.development.vscode.enable {
    home.packages = with pkgs; [
      vscode
      lens
    ];
  };
}
