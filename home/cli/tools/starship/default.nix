{
  lib,
  config,
  ...
}:
let
  pure = fromTOML (builtins.readFile ./pure-preset.toml);
in
{
  options.myHomeConfig.cli.tools.starship.enable = lib.mkEnableOption "starship";
  config = lib.mkIf config.myHomeConfig.cli.tools.starship.enable {
    programs.starship = {
      enable = true;
      settings = pure;
    };
  };
}
