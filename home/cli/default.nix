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

  options.myHomeConfig.cli = {
    enable = lib.mkEnableOption "Enable cli module";
    neovim.enable = lib.mkEnableOption "Enable neovim";
    neve.enable = lib.mkEnableOption "Enable neve";
    tools.enable = lib.mkEnableOption "Enable CLI tools";
  };

  config = lib.mkIf config.myHomeConfig.cli.enable {
    neovim.enable = lib.mkDefault config.myHomeConfig.cli.neovim.enable;
    neve.enable = lib.mkDefault config.myHomeConfig.cli.neve.enable;
    tools.enable = lib.mkDefault config.myHomeConfig.cli.tools.enable;
  };
}
