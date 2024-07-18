{
  lib,
  config,
  ...
}: {
  imports = [
    ./git
    ./http
    ./direnv
    ./languages
  ];

  options = {
    tools.enable = lib.mkEnableOption "Enable tools module";
  };
  config = lib.mkIf config.tools.enable {
    git.enable = lib.mkDefault true;
    http.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    languages.enable = lib.mkDefault true;
  };
}
