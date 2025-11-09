{
  pkgs,
  lib,
  config,
  homeDirectory,
  ...
}:
{
  options = {
    git.enable = lib.mkEnableOption "Enable git module";
  };
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      lfs = {
        enable = true;
      };
      settings = {
        user = {
          name = "redyf";
          email = "mateusalvespereira7@gmail.com";
        };
        core = {
          editor = "nvim";
        };
        init = {
          defaultBranch = "main";
        };
        branch = {
          autoSetupRemote = true;
        };
        fetch = {
          prune = true;
        };
        pull = {
          ff = false;
          commit = false;
          rebase = true;
          prune = true;
        };
        maintenance.repo = "${homeDirectory}/opensource/nixpkgs";
        safe = {
          directory = "${homeDirectory}/opensource/nixdots";
        };
      };
    };
    home.packages = with pkgs; [
      gh
    ];
  };
}
