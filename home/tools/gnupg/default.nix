{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    gnupg.enable = lib.mkEnableOption "Enable GnuPG module";
  };

  config = lib.mkIf config.gnupg.enable {
    home.packages = with pkgs; [
      gnupg
      pinentry-curses
    ];

    home.file.".local/share/gnupg/gpg-agent.conf".source = ./gpg-agent.conf;
  };
}
