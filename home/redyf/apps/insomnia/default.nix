{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.callPackage ../../../../pkgs/insomnia.nix {
      src = insomnia; # pkg source is passed as a `specialArgs` and injected into this module.
    })
  ];
}
