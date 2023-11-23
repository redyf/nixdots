{pkgs, ...}: {
  home.packages = with pkgs; [
    (python311.withPackages (ps:
      with ps; [
        pip
        xlib
        glib
        tqdm
        black # Python formatter
        pynvim
        flake8 # Linter for Python
        pypresence # Discord Rich Presence
        pygobject3 # Python bindings for Glib
        gst-python # Python bindings for GStreamer
      ]))
  ];
}
