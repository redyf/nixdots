{pkgs, ...}: {
  # Enable and configure `doas`.
  security = {
    sudo = {
      enable = true;
    };
    doas = {
      enable = true;
      extraRules = [
        {
          users = ["redyf"];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
}
