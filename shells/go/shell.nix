{pkgs, ...}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    go
  ];
}
