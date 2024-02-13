{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.common;
in
{
  options.suites.common = with types; {
    enable = mkBoolOpt false "Enable the common suite";
  };

  config = mkIf cfg.enable {
    apps = {
      misc = enabled;
    };

    hardware = {
      audio = enabled;
      networking = enabled;
      nvidia = enabled;
    };

    system = {
      boot = {
        bios = enabled;
        efi = disabled;
      };
      fonts = enabled;
      locale = enabled;
      nix = enabled;
      security.doas = enabled;
      time = enabled;
      xkb = enabled;
    };
  };
}
