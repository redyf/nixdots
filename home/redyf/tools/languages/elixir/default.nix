{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    elixir.enable = lib.mkEnableOption "Enable elixir module";
  };
  config = lib.mkIf config.elixir.enable {
    home.packages = with pkgs; [
      elixir
    ];
  };
}
