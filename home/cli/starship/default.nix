{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    starship.enable = lib.mkEnableOption "Enable starship module";
  };
  config = lib.mkIf config.starship.enable {
    programs.starship =
      let
        mochaPreset = import ./mocha.nix;
        mochav2 = import ./mochav2.nix { inherit pkgs; };
        oxocarbonPreset = import ./oxocarbon.nix;
        bloatedPreset = import ./bloated.nix;
        macchiatoPreset = import ./macchiato.nix { inherit pkgs; };
        oxocarbonv2 = builtins.fromTOML (builtins.readFile ./oxocarbonv2.toml);
      in
      {
        enable = true;
        enableZshIntegration = true;
        settings = mochav2;
      };
  };
}
