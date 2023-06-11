{ osConfig
, pkgs
, lib
, ...
}: {
  # Enables docker in rootless mode
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
