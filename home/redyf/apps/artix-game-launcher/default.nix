{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.callPackage ../../../../pkgs/artixlauncher.nix {
      src = artixlauncher; # pkg source is passed as a `specialArgs` and injected into this module.
    })
  ];
}
