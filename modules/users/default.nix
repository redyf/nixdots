{ lib, ... }:

{
  # options.myConfig.users = {
  #   enable = lib.mkEnableOption "Enable users configuration";
  #
  #   groups = {
  #     enable = lib.mkEnableOption "Enable groups";
  #   };
  # };
  imports = [
    ./groups.nix
  ];
}
