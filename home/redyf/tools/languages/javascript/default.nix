{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    javascript.enable = lib.mkEnableOption "Enable javascript module";
  };
  config = lib.mkIf config.javascript.enable {
    home.packages = with pkgs; [
      bun
      nodejs
      corepack
      typescript
      nodePackages.npm
    ];
  };
}
