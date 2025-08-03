{
  lib,
  config,
  ...
}:
{
  imports = [
    ./nix
    ./fonts
    ./shells
  ];

  options = {
    system.enable = lib.mkEnableOption "Enable system module";
  };
  config = lib.mkIf config.system.enable {
    nixy.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    shells.enable = lib.mkDefault true;
  };
}
