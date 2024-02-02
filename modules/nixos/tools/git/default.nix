{ options
, config
, pkgs
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.git;
in
{
  options.tools.git = with types; {
    enable = mkBoolOpt false "Enable or disable git";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.git = {
      enable = true;
      userName = "Redyf";
      userEmail = "mateusalvespereira7@gmail.com";
      extraConfig = {
        init = { defaultBranch = "main"; };
        core.editor = "nvim";
        pull.rebase = false;
      };
    };
  };
}
