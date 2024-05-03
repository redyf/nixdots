{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO: Disabled some of them to install with mason
    jdk # Java dev kit
    # jdt-language-server # Jdtls integration
    # checkstyle # Linter
    # google-java-format # Formatter
    maven # Build automation tool for java
    # gradle # Enterprise-grade build system
    # spring-boot-cli
    jetbrains.idea-community
  ];
}
