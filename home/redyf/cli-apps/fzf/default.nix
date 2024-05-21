_: let
  catppuccin = {
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
  nord = {
    fg = "#e5e9f0";
    bg = "#3b4252";
    hl = "#81a1c1";
    "fg+" = "#e5e9f0";
    "bg+" = "#3b4252";
    "hl+" = "#81a1c1";
    info = "#eacb8a";
    prompt = "#bf6069";
    pointer = "#b48dac";
    marker = "#a3be8b";
    spinner = "#b48dac";
    header = "#a3be8b";
  };
in {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux = {
      enableShellIntegration = true;
    };
    defaultOptions = [
      "--preview='bat --color=always {}'"
      "--multi"
      "--height 100%"
      "--layout=reverse-list"
      "--border=none"
      "--info=inline"
      "--bind shift-up:preview-page-up,shift-down:preview-page-down"
      "--header='CTRL-c or ESC to quit'"
    ];
  };
}
