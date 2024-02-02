{ options
, config
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.nix-ld;
in
{
  options.tools.nix-ld = with types; {
    enable = mkBoolOpt false "Enable nix-ld";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
