{ inputs
, config
, pkgs
, system
, ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withNodeJs = false;
    withPython3 = false;
  };
}
