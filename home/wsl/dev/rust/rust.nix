{pkgs, ...}: {
  home.packages = with pkgs; [
    # lldb # A next-generation high-performance debugger
    rustc # Compiler for rust
    cargo # Downloads your Rust project's dependencies and builds your project
    rustfmt # Formatter for rust language
    rust-analyzer # Lsp for rust
    # rustup # The Rust toolchain installer
  ];
}
