{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Redyf";
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
}
