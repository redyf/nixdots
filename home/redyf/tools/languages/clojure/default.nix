{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    clojure.enable = lib.mkEnableOption "Enable clojure module";
  };
  config = lib.mkIf config.clojure.enable {
    home.packages = with pkgs; [
      clojure # Clojure programming language
      babashka # Native, fast starting Clojure interpreter for scripting
      leiningen # Project automation for Clojure
      clojure-lsp # Language server protocol for Clojure
      clj-kondo # Linter for Clojure
      rlwrap # Clojure dependency
      zprint # Clojure formatter
    ];
  };
}
