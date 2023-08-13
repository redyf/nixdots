{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    ponysay
    pokemonsay
    pokemon-colorscripts-mac
  ];
  home.file.".config/fortunes" = {
    source = ./fortunes;
    recursive = true;
  };
}
