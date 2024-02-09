{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.development;
in
{
  options.suites.development = with types; {
    enable = mkBoolOpt false "Enable the development suite";
  };

  config = mkIf cfg.enable {
    apps = {
      insomnia = enabled;
    };
    cli-apps = {
      helix = disabled;
      neovim = disabled;
      neve = enabled;
      tmux = enabled;
    };
    desktop = {
      addons = {
        foot = enabled;
      };
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
