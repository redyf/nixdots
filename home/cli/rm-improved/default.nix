{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    rm-improved.enable = lib.mkEnableOption "Enable rm-improved module";
  };
  config = lib.mkIf config.rm-improved.enable {
    home.packages = with pkgs; [rm-improved];
  };
}
