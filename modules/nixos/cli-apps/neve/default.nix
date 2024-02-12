{
  inputs,
  options,
  config,
  pkgs,
  lib,
  system,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.cli-apps.neve;
  neve = inputs.Neve.packages.${system}.default;
in {
  options.cli-apps.neve = with types; {
    enable = mkBoolOpt false "Enable or disable Neve";
  };

  config = mkIf cfg.enable {
    environment = {
      variables = {
        EDITOR = "nvim";
      };
      systemPackages = with pkgs; [
        neve
        lazygit
        stylua
        sumneko-lua-language-server
        ripgrep
      ];
    };
  };
}
