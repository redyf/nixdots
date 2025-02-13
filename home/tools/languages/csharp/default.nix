{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    csharp.enable = lib.mkEnableOption "Enable C# module";
  };
  config = lib.mkIf config.csharp.enable {
    home.packages = with pkgs; [
      dotnet-sdk
      mono
      omnisharp-roslyn
      csharp-ls
      csharpier
    ];
  };
}
