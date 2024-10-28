{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    neovim.enable = lib.mkEnableOption "Enable neovim module";
  };
  config = lib.mkIf config.neovim.enable {
    home = {
      packages = with pkgs; [
        neovim
      ];
    };
  };
}
