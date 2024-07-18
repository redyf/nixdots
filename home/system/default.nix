{
  lib,
  config,
  ...
}: {
  imports = [
    ./nix
    ./fonts
    ./shell
  ];

  options = {
    system.enable = lib.mkEnableOption "Enable system module";
  };
  config = lib.mkIf config.system.enable {
    nixy.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    shell.enable = lib.mkDefault true;
  };
}
