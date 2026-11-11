{
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.fzf.enable = lib.mkEnableOption "fzf";
  config = lib.mkIf config.myHomeConfig.cli.tools.fzf.enable {
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
