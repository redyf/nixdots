{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    proton.enable = lib.mkEnableOption "Enable Steam module";
  };
  config = lib.mkIf config.proton.enable {
    home = {
      packages = with pkgs; [
        protonup
        bottles
      ];
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      };
    };
  };
}
