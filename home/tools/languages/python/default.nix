{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    python.enable = lib.mkEnableOption "Enable python module";
  };
  config = lib.mkIf config.python.enable {
    home.packages = with pkgs; [
      python3
      python312Packages.pip
    ];
  };
}
