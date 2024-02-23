{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.rust;
in {
  options.tools.languages.rust = with types; {
    enable = mkBoolOpt false "Enable rust";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cargo # Downloads your Rust project's dependencies and builds your project
      clippy # A bunch of lints to catch common mistakes and improve your Rust code
      # lldb # A next-generation high-performance debugger
      rust-analyzer # Lsp for rust
      rustc # Compiler for rust
      rustfmt # Formatter for rust language
      rustup # The Rust toolchain installer
    ];
  };
}
