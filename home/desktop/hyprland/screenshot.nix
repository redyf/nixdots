{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.myHomeConfig.desktop.hyprland.enable {
    home.packages = with pkgs; [
      (writeShellScriptBin "screenshot" ''
        grim -g "$(slurp)" - | wl-copy
      '')

      (writeShellScriptBin "screenshot-edit" ''
        wl-paste | swappy -f -
      '')
    ];
  };
}
