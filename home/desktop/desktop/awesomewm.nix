{pkgs, ...}: {
  home = {
    file = {
      ".config/awesome" = {
        source = ./awesomewm;
        recursive = true;
      };
    };
  };
}
