{ lib, ... }:

{
  options.myConfig.themes = {
    enable = lib.mkEnableOption "Enable Themes configuration";

    stylix = {
      enable = lib.mkEnableOption "Enable stylix ";
    };
  };

  imports = [
    ./stylix.nix
  ];
}
