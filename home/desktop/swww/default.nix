{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.desktop.swww.enable = lib.mkEnableOption "swww";
  config = lib.mkIf config.myHomeConfig.desktop.swww.enable {
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
