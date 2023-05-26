{pkgs, ...}: {
  home.packages = with pkgs; [
    #Python/pip packages
    (python311.withPackages (ps:
      with ps; [
        pip # Python package manager
        black # Python formatter
        tqdm
        pynvim
        flake8 # Linter for Python
        pygobject3 # Python bindings for Glib
        gst-python # Pyton bindings for GStreamer
        ascii-magic
        gobject-introspection # A middleware layer between C libraries and language bindings
      ]))
  ];
}
