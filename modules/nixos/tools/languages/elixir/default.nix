{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.elixir;
in
{
  options.tools.languages.elixir = with types; {
    enable = mkBoolOpt false "Enable elixir";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        elixir
        elixir-ls
      ];
    };
}
