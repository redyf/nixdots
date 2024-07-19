{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    spotify.enable = lib.mkEnableOption "Enable spotify module";
  };
  config = lib.mkIf config.spotify.enable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
