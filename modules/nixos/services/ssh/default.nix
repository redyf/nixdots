{ options
, config
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.services.ssh;
in
{
  options.services.ssh = with types; {
    enable = mkBoolOpt false "Enable ssh";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PermitRootLogin = "prohibit-password";
      };
    };

    users.users =
      let
        publicKey = ""; # Enter your ssh public key
      in
      {
        root.openssh.authorizedKeys.keys = [
          publicKey
        ];
        ${config.user.name}.openssh.authorizedKeys.keys = [
          publicKey
        ];
      };

    home.file.".ssh/config".text = ''
      identityfile ~/.ssh/key
    '';
  };
}
