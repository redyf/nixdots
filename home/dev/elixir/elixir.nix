{pkgs, ...}: {
  home.packages = with pkgs; [
    # Elixir packages
    elixir_1_14 # Elixir language

    elixir_ls
  ];
}
