{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    fastfetch.enable = lib.mkEnableOption "Enable fastfetch module";
  };
  config = lib.mkIf config.fastfetch.enable {
    home.packages = with pkgs; [
      fastfetch
    ];
  };
}
