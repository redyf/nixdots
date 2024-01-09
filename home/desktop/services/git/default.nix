_: {
  programs.git = {
    enable = true;
    userName = "Redyf";
    userEmail = "mateusalvespereira7@gmail.com";
    extraConfig = {
      init = { defaultBranch = "main"; };
      core.editor = "nvim";
      pull.rebase = false;
    };
  };
}
