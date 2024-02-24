{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.wsl;
in
{
  options.suites.wsl = with types; {
    enable = mkBoolOpt false "Enable the wsl suite";
  };

  config = mkIf cfg.enable {

    apps = {
      misc = enabled;
    };

    hardware = {
      networking = enabled;
    };

    system = {
      fonts = disabled;
      locale = enabled;
      nix = enabled;
      security.doas = disabled;
      time = enabled;
      xkb = enabled;
    };

    tools = {
      git = enabled;
      http = enabled;
      languages = {
        c = enabled;
        clojure = disabled;
        dart = disabled;
        elixir = disabled;
        go = disabled;
        java = enabled;
        javascript = enabled;
        lua = enabled;
        markdown = enabled;
        python = enabled;
        rust = enabled;
        sql = enabled;
      };
    };
  };
}
