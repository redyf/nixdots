{ lib
, osConfig
, pkgs
, ...
}: {
  programs.git = {
    enable = true;
    userName = "Will Byrne";
    userEmail = "will.alex.byrne@gmail.com";
    ignores = [
      ".idea"
    ];
    extraConfig = {
      init = { defaultBranch = "main"; };
    };
  };
}
