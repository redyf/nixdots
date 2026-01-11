{
  lib,
  config,
  ...
}:
{
  imports = [
    ./agents
    ./bat
    ./direnv
    ./eza
    ./fd
    ./fzf
    ./git
    ./http
    ./jq
    ./languages
    ./ripgrep
    ./starship
    ./tmux
    ./zoxide
  ];

  options = {
    tools.enable = lib.mkEnableOption "Enable CLI tools module";
  };
  config = lib.mkIf config.tools.enable {
    agents.enable = lib.mkDefault false;
    bat.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    fd.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    http.enable = lib.mkDefault true;
    jq.enable = lib.mkDefault true;
    languages.enable = lib.mkDefault true;
    ripgrep.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
  };
}
