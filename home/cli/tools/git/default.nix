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
      includes = [
        {
          path = "/run/secrets/rendered/git-personal";
        }
        {
          path = "/run/secrets/rendered/git-work";
          condition = "gitdir:${homeDirectory}/work/*/";
        }
      ];
      settings = {
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
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/id_ed25519";
        };

        "github-work" = {
          hostname = "github.com";
          user = "git";
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/id_ed25519_work";
        };
      };
    };
    home = {
      packages = [
        pkgs.gh
      ];
    };
  };
}
