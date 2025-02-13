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
    # programs.java.enable = true;
    home.packages = with pkgs; [
      jdk23_headless
      jdt-language-server # Jdtls integration
      maven # Build automation tool for java
      jetbrains.idea-community
      # gradle # Enterprise-grade build system
      # spring-boot-cli
      # checkstyle # Linter
      # google-java-format # Formatter
    ];
  };
}
