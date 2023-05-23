{ pkgs
, lib
, config
, osConfig
, inputs
, ...
}: {
  programs.xwaylandvideobridge = {
    enable = true;
    package = inputs.nix-config.packages.${pkgs.system}.xwaylandvideobridge;
  };
}
