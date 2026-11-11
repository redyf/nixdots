{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.neovim.enable = lib.mkEnableOption "neovim";
  config = lib.mkIf config.myHomeConfig.cli.neovim.enable {
    home.packages = with pkgs; [
      neovim
      tree-sitter
    ];
  };
}
