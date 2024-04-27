{pkgs, ...}: {
  home.packages = with pkgs; [
    elixir
  ];
}
