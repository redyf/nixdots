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
  cfg = config.cli-apps.bat;
in {
  options.cli-apps.bat = with types; {
    enable = mkBoolOpt false "Enable or disable bat";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Catppuccin-mocha";
      };
      themes = let
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          hash = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
      in {
        Catppuccin-mocha = {
          inherit src;
          file = "Catppuccin-mocha.tmTheme";
        };
        Catppuccin-latte = {
          inherit src;
          file = "Catppuccin-latte.tmTheme";
        };
      };
    };
  };
}
