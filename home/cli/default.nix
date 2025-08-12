{
  lib,
  config,
  ...
}:
{
  imports = [
    ./neovim
    ./neve
    ./utils
  ];

  options = {
    cli.enable = lib.mkEnableOption "Enable cli module";
  };
  config = lib.mkIf config.cli.enable {
    neovim.enable = lib.mkDefault true;
    neve.enable = lib.mkDefault false;
    utils.enable = lib.mkDefault true;
  };
}
