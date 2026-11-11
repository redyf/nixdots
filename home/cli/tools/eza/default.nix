{
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.eza.enable = lib.mkEnableOption "eza";
  config = lib.mkIf config.myHomeConfig.cli.tools.eza.enable {
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
