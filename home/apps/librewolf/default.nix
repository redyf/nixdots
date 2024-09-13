{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    librewolf.enable = lib.mkEnableOption "Enable librewolf module";
  };
  config = lib.mkIf config.librewolf.enable {
    programs.librewolf = {
      enable = true;
    };
  };
}
