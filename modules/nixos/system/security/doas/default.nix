{ options
, config
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.system.security.doas;
in
{
  options.system.security.doas = {
    enable = mkBoolOpt false "Whether or not to replace sudo with doas.";
  };

  config = mkIf cfg.enable {
    # Enable and configure `doas`.
    security = {
      sudo = {
        enable = false;
      };
      doas = {
        enable = true;
        extraRules = [
          {
            users = [ config.user.name ];
            noPass = true;
            keepEnv = true;
          }
        ];
      };
    };

    # Add an alias to the shell for backward-compat and convenience.
    environment.shellAliases = { sudo = "doas"; };
  };
}
