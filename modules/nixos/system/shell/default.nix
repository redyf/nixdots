{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.system.shell;
  themepkg = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "zsh-syntax-highlighting";
    rev = "06d519c20798f0ebe275fc3a8101841faaeee8ea";
    sha256 = "sha256-Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
  };
in
{
  options.system.shell = with types; {
    shell = mkOpt (enum [ "nushell" "fish" "zsh" ]) "zsh" "What shell to use";
  };

  config = {
    environment = {
      systemPackages = with pkgs; [
        fd
        jq
        bat
        eza
        fzf
        ripgrep
        rm-improved
        nitch
        zoxide
        starship
      ];
      shellAliases = {
        c = "nvim";
        cp = "cp -i";
        e = "emacsclient -c -a 'emacs'";
        f = "neofetch --sixel";
        p = "pfetch";
        fetch = "neofetch w3m";
        grep = "grep --color=auto";
        ls = "eza";
        la = "eza -a";
        mv = "mv -i";
        rip = "rip -i";
        rebuild = "cd ~/snowfall && doas nixos-rebuild switch --flake .#redyf";
        g = "git";
        ga = "git add";
        gaa = "git add .";
        gb = "git branch";
        gc = "git commit";
        gcm = "git commit --message";
        gco = "git checkout";
        gd = "git diff";
        gi = "git init";
        gp = "git pull";
        gs = "git status";
      };
    };

    users.defaultUserShell = pkgs.${cfg.shell};
    users.users.root.shell = pkgs.bashInteractive;

    environment.sessionVariables = {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };
    home =
      {
        extraOptions = {
          programs.bat = {
            enable = true;
            config = {
              pager = "less -FR";
              theme = "Catppuccin-mocha";
            };
            themes =
              let
                src = pkgs.fetchFromGitHub {
                  owner = "catppuccin";
                  repo = "bat";
                  rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
                  hash = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
                };
              in
              {
                Catppuccin-mocha = {
                  inherit src;
                  file = "Catppuccin-mocha.tmTheme";
                };
                Catppuccin-latte = {
                  inherit src;
                  file = "Catppuccin-latte.tmTheme";
                };
              };
          };
        };
        programs = {
          jq = {
            enable = true;
          };

          eza = {
            enable = true;
            icons = true;
            enableAliases = true;
          };

          fzf = {
            enable = true;
            enableZshIntegration = true;
            tmux = {
              enableShellIntegration = true;
            };
            colors = {
              bg = "-1";
              "bg+" = "-1";
              hl = "#ed8796";
              "hl+" = "#ed8796";
              fg = "#cad3f5";
              "fg+" = "#cad3f5";
              header = "#ed8796";
              info = "#c6a0f6";
              pointer = "#f4dbd6";
              marker = "#f4dbd6";
              prompt = "#c6a0f6";
              spinner = "#f4dbd6";
            };
          };

          ripgrep = {
            enable = true;
          };

          zoxide = {
            enable = true;
            enableZshIntegration = true;
            options = [ ];
          };

          # Actual Shell Configurations
          fish = mkIf (cfg.shell == " fish ") {
            enable = true;
            shellAliases = {
              ls = "
            eza - la - -icons - -no-user - -no-time - -git - s type ";
              cat = "
            bat ";
            };
            shellInit = ''
              ${mkIf apps.tools.direnv.enable ''
                direnv hook fish | source
              ''}

              zoxide init fish | source

              function , --description 'add software to shell session'
                    nix shell nixpkgs#$argv[1..-1]
              end
            '';
          };
          # Enable all if nushell
          nushell = mkIf
            (cfg.shell == "
            nushell ")
            {
              enable = true;
              shellAliases = config.environment.shellAliases // {
                ls = "
            ls ";
              };
              envFile.text = " ";
              extraConfig = ''
                  $env.config = {
                  	show_banner: false,
                  }

                  def , [...packages] {
                      nix shell ($packages | each {|s| $"
                nixpkgs#($s)"})
                }
              '';
            };

          zsh = mkIf (cfg.shell == "zsh") {
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
              export PATH="$PATH:/run/current-system/sw/bin/jdtls"
              export PATH="$PATH:/run/current-system/sw/bin/jdt-language-server"
              export PATH="$PATH:/home/redyf/.nix-profile/bin/elixir"
              export PATH="$PATH:/home/redyf/.nix-profile/bin/swww"
              export PATH="$PATH:/home/redyf/.nix-profile/bin/swww-daemon"
              export PATH="$PATH:$FORGIT_INSTALL_DIR/bin"
              export PATH="$PATH:/home/redyf/.config/nvim/bin"
              export WINIT_UNIX_BACKEND=x11 neovide

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
              c = "nvim";
              cp = "cp -i";
              e = "emacsclient -c -a 'emacs'";
              f = "neofetch --sixel";
              p = "pfetch";
              fetch = "neofetch w3m";
              grep = "grep --color=auto";
              ls = "eza";
              la = "eza -a";
              mv = "mv -i";
              rip = "rip -i";
              rebuild = "cd ~/snowfall && doas nixos-rebuild switch --flake .#redyf";
              postman = "postman --use-gl=desktop";
              insomnia = "insomnia --use-gl=desktop";
              beekeeper-studio = "beekeeper-studio --use-gl=desktop";
              g = "git";
              ga = "git add";
              gaa = "git add .";
              gb = "git branch";
              gc = "git commit";
              gcm = "git commit --message";
              gco = "git checkout";
              gd = "git diff";
              gi = "git init";
              gp = "git pull";
              gs = "git status";
            };

            oh-my-zsh = {
              enable = true;
              theme = "bira";
              plugins = [
                "git"
                "colorize"
                "colored-man-pages"
                "command-not-found"
                "history-substring-search"
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
              {
                name = "ctp-zsh-syntax-highlighting";
                src = themepkg;
                file = themepkg + "/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
              }
            ];
          };

          starship =
            let
              flavour = "macchiato"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
            in
            {
              enable = true;
              enableZshIntegration = true;
              settings =
                # Catppuccin
                {
                  scan_timeout = 10;
                  add_newline = false;
                  line_break.disabled = false;
                  right_format = "$time";
                  character = {
                    success_symbol = "[](#cbced3)";
                    error_symbol = "[](#dd6777)";
                    vicmd_symbol = "[](#ecd3a0)";
                    format = "$symbol[ ](bold #b4befe) ";
                    # format = "$symbol[λ ](bold #3fdaa4) ";
                    # format = "$symbol[✘ ](bold #3fdaa4) ";
                  };
                  palette = "catppuccin_${flavour}";
                  git_commit = { commit_hash_length = 5; };

                  lua.symbol = "[](blue) ";
                  python.symbol = "[](blue) ";
                  nix_shell.symbol = "[](blue) ";
                  rust.symbol = "[](red) ";
                  dart.symbol = "[](blue) ";
                  nodejs.version_format = "v$raw(blue)";
                  package.symbol = "📦  ";

                  username = {
                    show_always = false;
                    style_user = "bold bg:none fg:#7aa2f7";
                    format = "[$user]($style)";
                  };

                  hostname = {
                    disabled = true;
                    ssh_only = false;
                    style = "bold bg:none fg:#CDD6F4";
                    format = "@[$hostname]($style) ";
                  };

                  directory = {
                    read_only = " ";
                    truncation_length = 3;
                    truncation_symbol = "./";
                    # style = "bold bg:none fg:#393939";
                    # style = "bold bg:none fg:#7aa2f7";
                    style = "bold bg:none fg:#b4befe";
                    # style = "bold bg:none fg:#7dcfff";
                    # style = "bold bg:none fg:#ec6a88";
                  };

                  time = {
                    disabled = true;
                    use_12hr = true;
                    time_range = "-";
                    time_format = "%R";
                    utc_time_offset = "local";
                    format = "[ $time 󰥔]($style) ";
                    style = "bold #393939";
                  };
                }
                // builtins.fromTOML (builtins.readFile (pkgs.fetchFromGitHub
                  {
                    owner = "catppuccin";
                    repo = "starship";
                    rev = "HEAD";
                    sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
                  }
                + /palettes/${flavour}.toml));
            };

          # Mocha
          #   {
          #     add_newline = false;
          #     format = ''
          #       [](#b4befe)[  ](bg:#b4befe fg:black)[](bg:black fg:#b4befe)$directory[](black) $git_branch$nix_shell
          #       $character
          #     '';
          #     directory = {
          #       format = "[ $path ]($style)";
          #       style = "bg:black";
          #       truncate_to_repo = false;
          #     };
          #     git_branch = {
          #       style = "bold yellow";
          #     };
          #     character = {
          #       success_symbol = "[🠚 ](bold #b4befe)";
          #       error_symbol = "[🠚 ](bold #dd6777)";
          #     };
          #     nix_shell = {
          #       symbol = "[](bold #7aa2f7) ";
          #   };
          # };

          # Oxocarbon
          # {
          #   scan_timeout = 10;
          #   add_newline = true;
          #   line_break.disabled = false;
          #   format = "$symbol[󰉊 ](bold #ee5396) $directory$character";
          #   right_format = "$time";
          #   character = {
          #     success_symbol = "[󰅂 ](bold #393939)";
          #     error_symbol = "[󰅂 ](bold #393939)";
          #     vicmd_symbol = "[󰅂 ](bold #393939)";
          #   };
          # };
        };
      };
  };
}
