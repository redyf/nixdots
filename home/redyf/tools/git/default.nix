{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Redyf";
    userEmail = "mateusalvespereira7@gmail.com";
    extraConfig = {
      init = {defaultBranch = "main";};
      core.editor = "nvim";
      pull.rebase = false;
    };
  };
  home.packages = with pkgs; [
    gh
    lazygit
  ];
}
