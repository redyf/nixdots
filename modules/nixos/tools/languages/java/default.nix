{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.java;
in {
  options.tools.languages.java = with types; {
    enable = mkBoolOpt false "Enable java";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jdk # Java dev kit
      jdt-language-server # Jdtls integration
      checkstyle # Linter
      google-java-format # Formatter
      vscode-extensions.vscjava.vscode-java-debug
      vscode-extensions.vscjava.vscode-java-test
      maven # Build automation tool for java
      # spring-boot-cli
    ];
    tools = {
      intellij = disabled;
    };
  };
}
