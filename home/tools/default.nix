{
  lib,
  config,
  ...
}:
{
  imports = [
    ./direnv
    ./git
    ./gnupg
    ./http
    ./languages
  ];

  options = {
    tools.enable = lib.mkEnableOption "Enable tools module";
  };
  config = lib.mkIf config.tools.enable {
    direnv.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    gnupg.enable = lib.mkDefault true;
    http.enable = lib.mkDefault true;
    languages.enable = lib.mkDefault true;
  };
}
