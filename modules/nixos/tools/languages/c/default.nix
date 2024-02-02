{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.c;
in
{
  options.tools.languages.c = with types; {
    enable = mkBoolOpt false "Enable c";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        gcc
        cmake
        gnumake
        gnupatch
        astyle
        cpplint
        clang-tools
      ];
    };
}
