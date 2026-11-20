{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myHomeConfig.apps.security;
in
{
  options.myHomeConfig.apps.security = {
    enable = lib.mkEnableOption "security";
    sshAgent.enable = lib.mkEnableOption "Bitwarden desktop as the SSH agent";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
    ];

    home.sessionVariables = lib.mkIf cfg.sshAgent.enable {
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
    };

    systemd.user.services.bitwarden-desktop = lib.mkIf cfg.sshAgent.enable {
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
  };
}
