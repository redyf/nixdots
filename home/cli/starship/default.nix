{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    starship.enable = lib.mkEnableOption "Enable starship module";
  };
  config = lib.mkIf config.starship.enable {
    programs.starship = let
      mochaPreset = import ./mocha.nix;
      oxocarbonPreset = import ./oxocarbon.nix;
      bloatedPreset = import ./bloated.nix;
      catppuccinPreset = import ./catppuccin.nix {inherit pkgs;};
    in {
      enable = true;
      enableZshIntegration = true;
      settings = oxocarbonPreset;
    };
  };
}
