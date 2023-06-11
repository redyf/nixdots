{pkgs ? import <nixpkgs> {}}: let
  my-python-packages = ps:
    with ps; [
      glib
      pygobject3
      gst-python
    ];
  my-python = pkgs.python3.withPackages my-python-packages;
in
  my-python.env
