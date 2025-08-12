{
  lib,
  config,
  ...
}:
{
  imports = [
    ./nix
    ./fonts
  ];

  options = {
    system.enable = lib.mkEnableOption "Enable system module";
  };
  config = lib.mkIf config.system.enable {
    nixy.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
  };
}
