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
        macchiatoPreset = import ./macchiato.nix { inherit pkgs; };
        oxocarbonv2 = builtins.fromTOML (builtins.readFile ./oxocarbonv2.toml);
        christianLempaPrompt = builtins.fromTOML (builtins.readFile ./ChristianLempaPrompt.toml);
        modern = import ./modern.nix;
        catppuccin_powerline = builtins.fromTOML (builtins.readFile ./catppuccin-powerline.toml);
        pure = builtins.fromTOML (builtins.readFile ./pure-preset.toml);
      in
      {
        enable = true;
        settings = catppuccin_powerline;
      };
  };
}
