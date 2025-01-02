_: {
  programs = {
    ssh = {
      startAgent = true;
    };
  };
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
  };
}
