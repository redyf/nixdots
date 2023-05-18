{ config
, pkgs
, lib
, ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = "~/.config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      bad = "appimage-run ~/Downloads/BadlionClient";
      c = "nvim";
      cp = "cp -i";
      e = "emacsclient -c -a 'emacs'";
      f = "nitch";
      fetch = "neofetch";
      g = "git";
      gs = "git status";
      grep = "grep --color=auto";
      ll = "ls -l";
      ls = "exa";
      la = "exa -a";
      mv = "mv -i";
      nv = "lvimn";
      rm = "rm -i";
      v = "lvim";
    };

    plugins = with pkgs; [
      {
        name = "zsh-nix-shell";
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "forgit"; # i forgit :skull:
        file = "share/forgit/forgit.plugin.zsh";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "aa85792ec465ceee254be0e8e70d8703c7029f66";
          sha256 = "sha256-PGFYw7JbuYHOVycPlYcRItElcyuKEg2cGv4wn6In5Mo=";
        };
      }
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "7c390ee3bfa8069b8519582399e0a67444e6ea61";
          sha256 = "sha256-wLpgkX53wzomHMEpymvWE86EJfxlIb3S8TPy74WOBD4=";
        };
      }
      {
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      }
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "426271fb1bbe8aa88ff4010ca4d865b4b0438d90";
          sha256 = "sha256-RXqEW+jwdul2mKX86Co6HLsb26UrYtLjT3FzmHnwfAA=";
        };
      }
    ];
  };
}
