{ pkgs, ... }: {
  home.packages = with pkgs; [
    (python311.withPackages (ps:
      with ps; [
        pip
        xlib
        glib
        black # Python formatter
        pynvim
        flake8 # Linter for Python
        django
      ]))
  ];
}
