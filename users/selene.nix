{ config, ... }:
{
  imports = [ ../profiles/home/common.nix ];

  myHomeConfig.apps.security.enable = true;

  home.sessionVariables.SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
  myHomeConfig.cli.tools.git.githubIdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
  myHomeConfig.cli.tools.git.work.enable = false;
  myHomeConfig.cli.tools.git.workIdentityFile =
    "${config.home.homeDirectory}/.ssh/id_ed25519_work.pub";
  systemd.user.services.bitwarden-desktop = {
    Unit = {
      Description = "Bitwarden desktop (SSH agent)";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${config.home.profileDirectory}/bin/bitwarden";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
