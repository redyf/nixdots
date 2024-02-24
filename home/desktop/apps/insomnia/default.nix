{pkgs, ...}: {
  home.packages = with pkgs; [
    (pkgs.callPackage ../../../../packages/insomnia.nix {
      src = insomnia; # kernel source is passed as a `specialArgs` and injected into this module.
    })
  ];
}
