{ lib, config, ... }:
{
  imports = [
    ./misc
    ./obsidian
    ./vscode
  ];

  options = {
    development.enable = lib.mkEnableOption "Enable development module";
  };
  config = lib.mkIf config.development.enable {
    misc.enable = lib.mkDefault true;
    obsidian.enable = lib.mkDefault true;
    vscode.enable = lib.mkDefault true;
  };
}
