{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.rust;
in
{
  options.tools.languages.rust = with types; {
    enable = mkBoolOpt false "Enable rust";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        # lldb # A next-generation high-performance debugger
        rustc # Compiler for rust
        cargo # Downloads your Rust project's dependencies and builds your project
        rustfmt # Formatter for rust language
        rust-analyzer # Lsp for rust
        # rustup # The Rust toolchain installer
      ];
    };
}
