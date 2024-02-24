{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "wallpaper" ''
      /usr/bin/env ls ~/wallpapers/ | sort -R | tail -1 |while read file; do
          swww img ~/wallpapers/$file --transition-fps 60 --transition-type wipe
          echo "~/wallpapers/$file"
      done
    '')
    swww
  ];
}
