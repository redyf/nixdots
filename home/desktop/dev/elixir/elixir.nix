{pkgs, ...}: {
  home.packages = with pkgs; [
    elixir # Elixir language

    # Elixir packages
    elixir-ls # Lsp
  ];
}
