{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.http;
in
{
  options.tools.http = with types; {
    enable = mkBoolOpt false "Enable common http utils";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ wget curl httpie openssl ];
    };
}
