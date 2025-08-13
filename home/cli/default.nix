{
  lib,
  config,
  ...
}:
{
  imports = [
    ./neovim
    ./neve
    ./tools
  ];

  options = {
    cli.enable = lib.mkEnableOption "Enable cli module";
  };
  config = lib.mkIf config.cli.enable {
    neovim.enable = lib.mkDefault true;
    neve.enable = lib.mkDefault false;
    tools.enable = lib.mkDefault true;
  };
}
