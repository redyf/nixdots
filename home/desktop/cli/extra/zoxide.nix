{ pkgs, ... }: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ ];
  };
}
