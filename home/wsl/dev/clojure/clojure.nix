{pkgs, ...}: {
  home.packages = with pkgs; [
    # Clojure packages
    clojure # Clojure programming language
    babashka # Native, fast starting Clojure interpreter for scripting
    leiningen # Project automation for Clojure
    clojure-lsp # Language server protocol for Clojure
    clj-kondo # Linter for Clojure
    rlwrap # Clojure dependency
    zprint # Clojure formatter
  ];
}
