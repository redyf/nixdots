{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.addons.swww;
in
{
  options.desktop.addons.swww = with types; {
    enable = mkBoolOpt false "Enable or disable swww";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (pkgs.writeShellScriptBin "wallpaper" ''
        /usr/bin/env ls ~/wallpapers/ | sort -R | tail -1 |while read file; do
            swww img ~/wallpapers/$file --transition-fps 60 --transition-type wipe
            echo "~/wallpapers/$file"
        done
      '')
      swww
    ];
  };
}
