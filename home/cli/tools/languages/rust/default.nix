{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.languages.rust.enable = lib.mkEnableOption "rust";
  config = lib.mkIf config.myHomeConfig.cli.tools.languages.rust.enable {
    home.packages = with pkgs; [
      rustc
    ];
  };
}
