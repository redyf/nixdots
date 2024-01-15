{ pkgs, ... }: {
  home.packages = with pkgs; [
    # poetry
    (python311.withPackages (ps:
      with ps; [
        pip
        black # Python formatter
        pynvim
        flake8 # Linter for Python
        pypresence # Discord Rich Presence
      ]))
  ];
}
