{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    swww.enable = lib.mkEnableOption "Enable swww module";
  };
  config = lib.mkIf config.swww.enable {
    home.packages = with pkgs; [
      swww
      feh
      (writeShellScriptBin "wallpaper" ''
        /usr/bin/env ls ~/wallpapers/ | sort -R | tail -1 |while read file; do
            swww img ~/wallpapers/$file --transition-fps 60 --transition-type wipe
            echo "~/wallpapers/$file"
        done
      '')
    ];
  };
}
