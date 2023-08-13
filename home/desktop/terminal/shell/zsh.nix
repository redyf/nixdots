{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      # Export PATHs for applications
      export PATH=$PATH:~/.local/bin/
      export PATH=/tmp/lazy-lvim/bin:$PATH
      export PATH="$HOME/.emacs.d/bin:$PATH"
      export PATH="$PATH:/home/luna/.nix-profile/bin/elixir"
      export PATH="$PATH:/home/luna/.nix-profile/bin/swww"
      export PATH="$PATH:/home/luna/.nix-profile/bin/swww-daemon"
      export PATH="$PATH:$FORGIT_INSTALL_DIR/bin"
      export PATH="$PATH:/home/luna/.config/nvim/bin"
      export PATH="$PATH:/home/luna/.config/nyoom/bin"
      NIX_PATH="$NIX_PATH:nixpkgs-overlays=/home/luna/flake/overlays/"

      # Autosuggest
      ZSH_AUTOSUGGEST_USE_ASYNC="true"

      while read -r option
      do
        setopt $option
      done <<-EOF
      AUTO_CD
      AUTO_LIST
      AUTO_MENU
      AUTO_PARAM_SLASH
      AUTO_PUSHD
      APPEND_HISTORY
      ALWAYS_TO_END
      COMPLETE_IN_WORD
      CORRECT
      EXTENDED_HISTORY
      HIST_EXPIRE_DUPS_FIRST
      HIST_FCNTL_LOCK
      HIST_IGNORE_ALL_DUPS
      HIST_IGNORE_DUPS
      HIST_IGNORE_SPACE
      HIST_REDUCE_BLANKS
      HIST_SAVE_NO_DUPS
      HIST_VERIFY
      INC_APPEND_HISTORY
      INTERACTIVE_COMMENTS
      MENU_COMPLETE
      NO_NOMATCH
      PUSHD_IGNORE_DUPS
      PUSHD_TO_HOME
      PUSHD_SILENT
      SHARE_HISTORY
      EOF

      while read -r option
      do
        unsetopt $option
      done <<-EOF
      CORRECT_ALL
      HIST_BEEP
      MENU_COMPLETE
      EOF

      # Group matches and describe.
      zstyle ':completion:*' sort false
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
       zstyle ':completion:*' special-dirs true
       zstyle ':completion:*' rehash true

       zstyle ':completion:*' menu yes select # search
       zstyle ':completion:*' list-grouped false
       zstyle ':completion:*' list-separator '''
       zstyle ':completion:*' group-name '''
       zstyle ':completion:*' verbose yes
       zstyle ':completion:*:matches' group 'yes'
       zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
       zstyle ':completion:*:messages' format '%d'
       zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
       zstyle ':completion:*:descriptions' format '[%d]'

       # Fuzzy match mistyped completions.
       zstyle ':completion:*' completer _complete _match _approximate
       zstyle ':completion:*:match:*' original only
       zstyle ':completion:*:approximate:*' max-errors 1 numeric

       # Don't complete unavailable commands.
       zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

       # Array completion element sorting.
       zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

       # fzf-tab
       zstyle ':fzf-tab:complete:_zlua:*' query-string input
       zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
       zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
       zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
       zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
       zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
       zstyle ':fzf-tab:*' switch-group ',' '.'
       zstyle ":completion:*:git-checkout:*" sort false
       zstyle ':completion:*' file-sort modification
       zstyle ':completion:*:exa' sort false
       zstyle ':completion:files' sort false

    '';

    shellAliases = {
      bad = "appimage-run ~/Downloads/BadlionClient";
      c = "nvim";
      cp = "cp -i";
      f = "neofetch --sixel $HOME/.config/neofetch/images/nixos.png";
      fetch = "neofetch w3m";
      g = "git";
      gs = "git status";
      guc="git clean -xdf";
      grep = "grep --color=auto";
      ll = "ls -l";
      ls = "exa";
      la = "exa -a";
      mv = "mv -i";
      rip = "rip -i";
      rebuild = "cd ~/flake && doas nixos-rebuild switch --flake .#desktop --impure";
      vi = "lvim";
      wget = "wget -q --show-progress --progress=bar:force:noscroll";
      open = "xdg-open";
      dps = "docker ps";
      dsp = "docker system prune -a";
      dspf = "docker system prune -af";
      dkill = "docker kill $(docker ps -q)";
      drm = "docker rm $(docker ps -a -q)";
      drmi = "docker rmi $(docker images -q)";
      dcu = "docker compose up";
      dcud = "docker compose up -d";
      dcd = "docker compose down";
      docker-compose = "docker compose";
      poke70 = "clear && fortune ~/.config/fortunes/70maxims | pokemonsay";
      pokelord = "clear && fortune ~/.config/fortunes/overlord | pokemonsay";
      pokeloveless = "clear && fortune ~/.config/fortunes/loveless | pokemonsay";
      luna70 = "clear && fortune ~/.config/fortunes/70maxims | ponysay -f luna";
      lunalord = "clear && fortune ~/.config/fortunes/overlord | ponysay -f luna";
      lunaloveless = "clear && fortune ~/.config/fortunes/loveless | ponysay -f luna";
      lunasith = "clear && fortune ~/.config/fortunes/sith | ponysay -f luna";
      lunasithwatch = "while true ; do lunasith;  sleep 30 ; done";
      poke70watch = "while true ; do poke70;  sleep 30 ; done";
      pokelordwatch = "while true ; do pokelord;  sleep 30 ; done";
      pokelovelesswatch = "while true ; do pokeloveless;  sleep 30 ; done";
      luna70watch="while true ; do luna70;  sleep 30 ; done";
      lunalordwatch="while true ; do lunalord;  sleep 30 ; done";
      lunalovelesswatch="while true ; do lunaloveless;  sleep 30 ; done";
      cowlordwatch="while true ; do cowlord;  sleep 30 ; done";
      starwars="telnet towel.blinkenlights.nl";
      eppc="cd ~/git/enhanced-preprints-client";
      epps="cd ~/git/enhanced-preprints-server";
      eppi="cd ~/git/enhanced-preprints-import";
      oops="fuck";
    };

    oh-my-zsh = {
      enable = true;
      theme = "bira";
      plugins = [
        "git"
        # "git z"
        "colorize"
        "colored-man-pages"
        "command-not-found"
        "history-substring-search"
        "thefuck"
      ];
    };

    plugins = with pkgs; [
      {
        name = "forgit"; # i forgit :skull:
        file = "forgit.plugin.zsh";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "99cda3248c205ba3c4638c4e461afce01a2f8acb";
          sha256 = "0jd0nl0nf7a5l5p36xnvcsj7bqgk0al2h7rdzr0m1ldbd47mxdfa";
        };
      }
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "13d7b4e63468307b6dcb2dadf6150818f242cbff";
          sha256 = "0ghzqg1xfvqh9z23aga7aafrpxbp9bpy1r8vk4avi6b80p3iwsq2";
        };
      }
      {
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
          sha256 = "0q9wg8jlhlz2xn08rdml6fljglqd1a2gbdp063c8b8ay24zz2w9x";
        };
      }
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "5a81e13792a1eed4a03d2083771ee6e5b616b9ab";
          sha256 = "0lfl4r44ci0wflfzlzzxncrb3frnwzghll8p365ypfl0n04bkxvl";
        };
      }
    ];
  };
}
