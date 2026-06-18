{
  username,
  homeDirectory,
  ...
}:
{
  imports = [
    ../../profiles/home/minimal.nix
    ../apps
    ../cli
    ../desktop
    ../shells
    ../system
  ];

  home = {
    inherit username homeDirectory;
    stateVersion = "25.05";
    sessionPath = [ "$HOME/.local/bin" ];
  };

  brave.enable = false;
  chrome.enable = false;
  firefox.enable = true;
  git.enable = false;
  zen.enable = false;

  nixpkgs.config.allowUnfree = true;
}
