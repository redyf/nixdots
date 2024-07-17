{
  lib,
  config,
  ...
}: {
  options = {
    direnv.enable = lib.mkEnableOption "Enable direnv module";
  };

  config = lib.mkIf config.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
