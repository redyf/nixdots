{
  lib,
  config,
  ...
}:
{
  imports = [
    ./bat
    ./eza
    ./fd
    ./fzf
    ./jq
    ./ripgrep
    ./starship
    ./tmux
    ./zoxide
  ];

  options = {
    utils.enable = lib.mkEnableOption "Enable cli utils module";
  };
  config = lib.mkIf config.utils.enable {
    bat.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    fd.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    jq.enable = lib.mkDefault true;
    ripgrep.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
  };
}
