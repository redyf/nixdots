{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.gnupg;
in
{
  options.tools.gnupg = with types; {
    enable = mkBoolOpt false "Enable gnupg";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.pinentry pkgs.pinentry-curses ];

    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      pinentryFlavor = "curses";
      enableSSHSupport = true;
    };

    home.file.".local/share/gnupg/gpg-agent.conf".source = ./gpg-agent.conf;

    environment.variables = {
      GNUPGHOME = "$XDG_DATA_HOME/gnupg";
    };
  };
}
