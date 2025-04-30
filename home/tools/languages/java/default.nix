{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    java.enable = lib.mkEnableOption "Enable java module";
  };
  config = lib.mkIf config.java.enable {
    # programs.java = {
    #   enable = true;
    #   package = pkgs.jdk17_headless;
    # };
    home.packages = with pkgs; [
      # jdk17_headless
      jdk23_headless
      # jdt-language-server # Jdtls integration
      maven # Build automation tool for java
      spring-boot-cli
      vscode-extensions.vscjava.vscode-java-debug
      # jetbrains.idea-community
      # gradle # Enterprise-grade build system
      # checkstyle # Linter
      # google-java-format # Formatter
    ];
  };
}
