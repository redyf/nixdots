{ lib, config, ... }:
{
  imports = [
    ./db
    ./inkdrop
    ./intellij
    ./obsidian
    ./rider
    ./vscode
  ];

  options = {
    development.enable = lib.mkEnableOption "Enable development module";
  };
  config = lib.mkIf config.development.enable {
    database.enable = lib.mkDefault true;
    inkdrop.enable = lib.mkDefault false;
    intellij.enable = lib.mkDefault false;
    obsidian.enable = lib.mkDefault true;
    rider.enable = lib.mkDefault false;
    vscode.enable = lib.mkDefault true;
  };
}
