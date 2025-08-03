{
  lib,
  config,
  ...
}:
{
  imports = [
    ./nushell
    ./shell
    ./zsh
  ];
  options = {
    shells.enable = lib.mkEnableOption "Enable shells module";
  };
  config = lib.mkIf config.shells.enable {
    nushell.enable = lib.mkDefault false;
    shell.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
  };
}
