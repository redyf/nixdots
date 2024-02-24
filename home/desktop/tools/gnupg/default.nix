{pkgs, ...}: {
  environment.systemPackages = [pkgs.pinentry pkgs.pinentry-curses];

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
}
