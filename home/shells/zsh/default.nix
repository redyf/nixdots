{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh module";
  };
  config = lib.mkIf config.zsh.enable {
    home = {
      shell = {
        enableZshIntegration = true;
      };
    };
    programs = {
      zsh = {
        enable = true;
        dotDir = "${config.xdg.configHome}/zsh";
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        initContent = ''
          bindkey -s ^f "tmux-sessionizer-script\n"
          tmux-init
          export PATH=$PATH:~/.local/bin/
          export PATH=/tmp/lazy-lvim/bin:$PATH

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
          grep = "grep --color=auto";
          mv = "mv -i";
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
          nb = "nix-build";
          nd = "nix develop";
          nr = "nix run";
          ns = "nix-shell";
          nu = "nix-update";
          wo = "pomodoro 'work'";
          br = "pomodoro 'break'";
          cy = "pomodoro 'cycle'";

          # K8s
          k = "kubectl";
          ka = "kubectl apply -f";
          kg = "kubectl get";
          kd = "kubectl describe";
          kdel = "kubectl delete";
          kl = "kubectl logs";
          kgpo = "kubectl get pod";
          kgd = "kubectl get deployments";
          kc = "kubectx";
          kns = "kubens";
          ke = "kubectl exec -it";

          cursor = "steam-run cursor-agent";
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
            name = "zsh-autopair";
            file = "zsh-autopair.plugin.zsh";
            src = zsh-autopair;
          }
          {
            name = "fzf-tab";
            file = "fzf-tab.plugin.zsh";
            src = zsh-fzf-tab;
          }
        ];
      };
    };
  };
}
