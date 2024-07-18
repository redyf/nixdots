{
  lib,
  config,
  ...
}: {
  options = {
    zoxide.enable = lib.mkEnableOption "Enable zoxide module";
  };
  config = lib.mkIf config.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
