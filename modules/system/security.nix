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
          users = ["redyf" "selene"];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
}
