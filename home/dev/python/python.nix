{pkgs, ...}: {
  home.packages = with pkgs; [
    (python311.withPackages (ps:
      with ps; [
        black # Python formatter
        tqdm
        pynvim
        flake8 # Linter for Python
        pygobject3 # Python bindings for Glib
        gst-python # Python bindings for GStreamer
      ]))
  ];
}
