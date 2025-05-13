{
  lib,
  config,
  ...
}:
{
  imports = [
    ./nvim
    ./neve
    ./utils
  ];

  options = {
    cli.enable = lib.mkEnableOption "Enable cli module";
  };
  config = lib.mkIf config.cli.enable {
    nvim.enable = lib.mkDefault true;
    neve.enable = lib.mkDefault false;
    utils.enable = lib.mkDefault true;
  };
}
