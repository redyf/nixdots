{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.development;
in {
  options.suites.development = with types; {
    enable = mkBoolOpt false "Enable the development suite";
  };

  config = mkIf cfg.enable {
    apps = {
      insomnia = enabled;
    };
    cli-apps = {
      bat = enabled;
      eza = enabled;
      fd = enabled;
      fzf = enabled;
      helix = disabled;
      jq = enabled;
      neovim = disabled;
      neve = enabled;
      ripgrep = enabled;
      rm-improved = enabled;
      starship = enabled;
      tmux = enabled;
      zoxide = enabled;
    };
    tools = {
      git = enabled;
      http = enabled;
      direnv = enabled;
      gnupg = disabled;
      nix-ld = disabled;
      languages = {
        c = enabled;
        java = enabled;
        rust = enabled;
        python = enabled;
        sql = enabled;
        javascript = enabled;
        lua = enabled;
        markdown = enabled;
      };
    };
    virtualization = {
      kvm = enabled;
    };
  };
}
