{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    bat.enable = lib.mkEnableOption "Enable bat module";
  };
  config = lib.mkIf config.bat.enable {
    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "CatppuccinMocha";
      };
      themes =
        let
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "699f60fc8ec434574ca7451b444b880430319941";
            hash = "sha256-6fWoCH90IGumAMc4buLRWL0N61op+AuMNN9CAR9/OdI=";
          };
        in
        {
          CatppuccinMocha = {
            inherit src;
            file = "Catppuccin Mocha.tmTheme";
          };
        };
    };
  };
}
