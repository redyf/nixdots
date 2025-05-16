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
        mocha = import ./mocha.nix;
        oxocarbon = import ./oxocarbon.nix;
        catppuccinPowerline = builtins.fromTOML (builtins.readFile ./catppuccin-powerline.toml);
        pure = builtins.fromTOML (builtins.readFile ./pure-preset.toml);
        tuxdot = import ./tuxdot.nix;
      in
      {
        enable = true;
        settings = catppuccinPowerline;
      };
  };
}
