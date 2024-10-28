{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    # For home-manager
    inputs.nixvim.homeManagerModules.nixvim
  ];
  options = {
    neve.enable = lib.mkEnableOption "Enable neve module";
  };
  config = lib.mkIf config.neve.enable {
    home.packages = with pkgs; [
      inputs.Neve.packages.${system}.default
    ];
    # programs.nixvim = {
    #   enable = true;
    #   imports = [ inputs.Neve.nixvimModule ];
    #   # Then configure Nixvim as usual, you might have to lib.mkForce some of the settings
    #   colorschemes.catppuccin.enable = lib.mkForce true;
    #   # colorschemes.nord.enable = true;
    # };
  };
}
