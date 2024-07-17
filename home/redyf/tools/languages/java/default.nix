{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    java.enable = lib.mkEnableOption "Enable java module";
  };
  config = lib.mkIf config.java.enable {
    home.packages = with pkgs; [
      jdk # Java dev kit
      # jdt-language-server # Jdtls integration
      # checkstyle # Linter
      # google-java-format # Formatter
      # maven # Build automation tool for java
      # gradle # Enterprise-grade build system
      # spring-boot-cli
      jetbrains.idea-community
    ];
  };
}
