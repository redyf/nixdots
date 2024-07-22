{username, ...}: {
  security = {
    sudo = {
      enable = true;
    };
    doas = {
      enable = true;
      extraRules = [
        {
          users = [username];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
}
