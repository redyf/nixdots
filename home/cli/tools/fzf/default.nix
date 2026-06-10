{
  lib,
  config,
  ...
}:
{
  options = {
    fzf.enable = lib.mkEnableOption "Enable fzf module";
  };
  config = lib.mkIf config.fzf.enable {
    programs.fzf = {
      enable = true;
      defaultOptions = [
        "--preview='bat --color=always {}'"
        "--multi"
        "--height 100%"
        "--layout=reverse-list"
        "--border=none"
        "--info=inline"
        "--bind shift-up:preview-page-up,shift-down:preview-page-down"
        "--header='CTRL-c or ESC to quit'"
        "--color=bg:-1,bg+:-1"
      ];
    };
  };
}
