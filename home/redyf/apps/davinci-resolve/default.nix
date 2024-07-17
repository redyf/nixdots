{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    davinci-resolve.enable = lib.mkEnableOption "Enable davinci-resolve module";
  };
  config = lib.mkIf config.davinci-resolve.enable {
    home.packages = with pkgs; [
      davinci-resolve
    ];
  };
}
