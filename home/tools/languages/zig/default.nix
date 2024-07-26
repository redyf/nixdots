{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    zig.enable = lib.mkEnableOption "Enable zig module";
  };
  config = lib.mkIf config.zig.enable {
    home.packages = with pkgs; [
      zig
    ];
  };
}
