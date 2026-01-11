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
        setOptions = [
          "AUTO_CD"
          "AUTO_LIST"
          "AUTO_MENU"
          "AUTO_PARAM_SLASH"
          "AUTO_PUSHD"
          "APPEND_HISTORY"
          "ALWAYS_TO_END"
          "COMPLETE_IN_WORD"
          "CORRECT"
          "EXTENDED_HISTORY"
          "HIST_EXPIRE_DUPS_FIRST"
          "HIST_FCNTL_LOCK"
          "HIST_IGNORE_ALL_DUPS"
          "HIST_IGNORE_DUPS"
          "HIST_IGNORE_SPACE"
          "HIST_REDUCE_BLANKS"
          "HIST_SAVE_NO_DUPS"
          "HIST_VERIFY"
          "INC_APPEND_HISTORY"
          "INTERACTIVE_COMMENTS"
          "MENU_COMPLETE"
          "NO_NOMATCH"
          "PUSHD_IGNORE_DUPS"
          "PUSHD_TO_HOME"
          "PUSHD_SILENT"
          "SHARE_HISTORY"
          "NO_CORRECT_ALL"
          "NO_HIST_BEEP"
        ];

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
        };

        oh-my-zsh = {
          enable = true;
          theme = "";
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

        initContent = ''
          bindkey -s ^f "tmux-sessionizer-script\n"
          tmux-init
          export PATH=$PATH:~/.local/bin/
          export PATH=/tmp/lazy-lvim/bin:$PATH

          ZSH_AUTOSUGGEST_USE_ASYNC="true"

          TRANSIENT_PROMPT=$(${pkgs.starship}/bin/starship module character)

          function zle-line-init() {
              emulate -L zsh
              [[ $CONTEXT == start ]] || return 0
              while true; do
                  zle .recursive-edit
                  local -i ret=$?
                  [[ $ret == 0 && $KEYS == $'\4' ]] || break
                  [[ -o ignore_eof ]] || exit 0
              done

              local saved_prompt=$PROMPT
              local saved_rprompt=$RPROMPT

              # IMPORTANTE: Desativa os hooks do Starship temporariamente
              # para ele não redesenhar o prompt completo na linha anterior
              local saved_precmd_functions=("''${precmd_functions[@]}")
              precmd_functions=()

              PROMPT=$TRANSIENT_PROMPT
              RPROMPT="" 
              zle .reset-prompt
              
              PROMPT=$saved_prompt
              RPROMPT=$saved_rprompt
              precmd_functions=("''${saved_precmd_functions[@]}")

              if (( ret )); then
                  zle .send-break
              else
                  zle .accept-line
              fi
              return ret
          }
          zle -N zle-line-init

          # Zstyle completions
          zstyle ':completion:*' sort false
          zstyle ':completion:complete:*:options' sort false
          zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
          zstyle ':completion:*' special-dirs true
          zstyle ':completion:*' rehash true
          zstyle ':completion:*' menu yes select
          zstyle ':completion:*' list-grouped false
          zstyle ':completion:*' verbose yes
          zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'

          # fzf-tab styles
          zstyle ':fzf-tab:complete:_zlua:*' query-string input
          zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
          zstyle ':fzf-tab:complete:cd:*' fzf-preview '${pkgs.eza}/bin/eza -1 --color=always $realpath'
          zstyle ':fzf-tab:*' switch-group ',' '.'

          autoload -Uz edit-command-line
          zle -N edit-command-line
          bindkey '^x^e' edit-command-line

          alias -s json='jless'

          alias -s {txt,nix}='$EDITOR'

          alias -s md='bat'
        '';
      };
    };
  };
}
