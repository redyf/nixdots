{
  lib,
  config,
  ...
}:
let
  # mocha = import ./mocha.nix;
  # oxocarbon = import ./oxocarbon.nix;
  # simple = fromTOML (builtins.readFile ./simple.toml);
  pure = fromTOML (builtins.readFile ./pure-preset.toml);
in
{
  options = {
    starship.enable = lib.mkEnableOption "Enable starship module";
  };
  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
      settings = pure;
    };
  };
}
