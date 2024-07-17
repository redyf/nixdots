{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    vscode.enable = lib.mkEnableOption "Enable vscode module";
  };
  config = lib.mkIf config.vscode.enable {
    home.packages = with pkgs; [
      vscode
      gnome.gnome-keyring
    ];
  };
}
