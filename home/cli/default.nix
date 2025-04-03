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
    ./nvim
    ./neve
    ./ripgrep
    ./starship
    ./tmux
    ./zoxide
  ];

  options = {
    cli.enable = lib.mkEnableOption "Enable cli module";
  };
  config = lib.mkIf config.cli.enable {
    bat.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    fd.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    jq.enable = lib.mkDefault true;
    nvim.enable = lib.mkDefault true;
    neve.enable = lib.mkDefault false;
    ripgrep.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
  };
}
