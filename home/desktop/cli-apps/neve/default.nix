{ inputs
, config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    inputs.Neve.packages.${system}.default
  ];
}
