{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO: Disabled some of them to install with mason
    jdk # Java dev kit
    # jdt-language-server # Jdtls integration
    checkstyle # Linter
    google-java-format # Formatter
    # vscode-extensions.vscjava.vscode-java-debug
    # vscode-extensions.vscjava.vscode-java-test
    maven # Build automation tool for java
    gradle
    # spring-boot-cli
  ];
}
