{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.clojure;
in
{
  options.tools.languages.clojure = with types; {
    enable = mkBoolOpt false "Enable clojure";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        # Clojure packages
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
