{ options
, config
, pkgs
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.cli-apps.neovim;
in
{
  options.cli-apps.neovim = with types; {
    enable = mkBoolOpt false "Enable or disable neovim";
  };

  config = mkIf cfg.enable {
    environment = {
      variables = {
        EDITOR = "nvim";
      };
      systemPackages = with pkgs; [
        neovim
        lazygit
        stylua
        sumneko-lua-language-server
        ripgrep
      ];
    };
  };
}
