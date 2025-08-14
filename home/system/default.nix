{
  lib,
  config,
  ...
}:
{
  imports = [
    ./fonts
    ./nix
    ./utils
  ];

  options = {
    system.enable = lib.mkEnableOption "Enable system module";
  };
  config = lib.mkIf config.system.enable {
    fonts.enable = lib.mkDefault true;
    nixy.enable = lib.mkDefault true;
    utils.enable = lib.mkDefault true;
  };
}
