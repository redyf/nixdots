{ inputs
, options
, config
, pkgs
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.cli-apps.neve;
in
{
  options.cli-apps.neve = with types; {
    enable = mkBoolOpt false "Enable or disable Neve";
  };

  config = mkIf cfg.enable {
    environment = {
      variables = {
        EDITOR = "nvim";
      };
      systemPackages = with pkgs; [
        inputs.Neve.packages.${system}.default
        lazygit
        stylua
        sumneko-lua-language-server
        ripgrep
      ];
    };
  };
}
