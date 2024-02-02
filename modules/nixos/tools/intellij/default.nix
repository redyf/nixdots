{ options
, config
, pkgs
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.intellij;
in
{
  options.tools.intellij = with types; {
    enable = mkBoolOpt false "Enable or disable intellij IDE";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        jetbrains.idea-community
      ];
    };
  };
}
