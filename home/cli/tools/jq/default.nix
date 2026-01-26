{
  lib,
  config,
  ...
}:
{
  options = {
    jq.enable = lib.mkEnableOption "Enable jq module";
  };
  config = lib.mkIf config.jq.enable {
    programs.jq = {
      enable = true;
    };
  };
}
