{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    git.enable = lib.mkEnableOption "Enable git module";
  };
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "Redyf";
      userEmail = "mateusalvespereira7@gmail.com";
      extraConfig = {
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
        maintenance.repo = "/home/redyf/opensource/nixpkgs";
      };
    };
    home.packages = with pkgs; [
      gh
      lazygit
    ];
  };
}
