{
  imports = [
    ../../profiles/home/minimal.nix
    ../apps
    ../cli
    ../desktop
    ../shells
    ../system
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];

  brave.enable = false;
  chrome.enable = false;
  firefox.enable = true;
  git.enable = false;
  zen.enable = false;
}
