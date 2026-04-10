{ lib, config, ... }:
{
  imports = [
    ./api-client
    ./db
    ./intellij
    ./obsidian
    ./rider
    ./vscode
  ];

  options = {
    development.enable = lib.mkEnableOption "Enable development module";
  };
  config = lib.mkIf config.development.enable {
    api-client.enable = lib.mkDefault true;
    database.enable = lib.mkDefault true;
    intellij.enable = lib.mkDefault true;
    obsidian.enable = lib.mkDefault true;
    rider.enable = lib.mkDefault false;
    vscode.enable = lib.mkDefault true;
  };
}
