{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      jetbrains.idea-community
    ];
  };
}
