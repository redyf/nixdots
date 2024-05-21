{pkgs, ...}: {
  home.packages = with pkgs; [
    ocaml
    opam
  ];
}
