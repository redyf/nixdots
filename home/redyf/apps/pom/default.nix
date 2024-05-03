{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.callPackage ../../../../pkgs/pom.nix {
      src = pom; # pkg source is passed as a `specialArgs` and injected into this module.
    })
  ];
}
