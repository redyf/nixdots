{
  lib,
  config,
  ...
}:
{
  options = {
    eza.enable = lib.mkEnableOption "Enable eza module";
  };
  config = lib.mkIf config.eza.enable {
    programs.eza = {
      enable = true;
      icons = "auto";
      colors = "always";
      extraOptions = [
        "--no-filesize"
        "--long"
        "--no-user"
      ];
    };
  };
}
