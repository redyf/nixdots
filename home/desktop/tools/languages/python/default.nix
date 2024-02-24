{pkgs, ...}: {
  home.packages = with pkgs; [
    poetry
    (python311.withPackages (ps:
      with ps; [
        black # Python formatter
        pynvim
        flake8 # Linter for Python
      ]))
  ];
}
