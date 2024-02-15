{ config
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.cli-apps.zoxide;
in
{
  options.cli-apps.zoxide = with types; {
    enable = mkBoolOpt false "Enable or disable zoxide";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
