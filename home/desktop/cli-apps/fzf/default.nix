_: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux = {
      enableShellIntegration = true;
    };
    colors = {
      bg = "-1";
      "bg+" = "-1";
      hl = "#ed8796";
      "hl+" = "#ed8796";
      fg = "#cad3f5";
      "fg+" = "#cad3f5";
      header = "#ed8796";
      info = "#c6a0f6";
      pointer = "#f4dbd6";
      marker = "#f4dbd6";
      prompt = "#c6a0f6";
      spinner = "#f4dbd6";
    };
  };
}
