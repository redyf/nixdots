{
  lib,
  config,
  ...
}:
{
  options = {
    nushell.enable = lib.mkEnableOption "Enable nushell module";
  };
  config = lib.mkIf config.nushell.enable {
    home = {
      shell = {
        enableNushellIntegration = true;
      };
    };
    programs = {
      nushell = {
        enable = true;
        environmentVariables.TERMINAL = "ghostty";
        extraConfig = ''
          let dark_theme = {
              separator: white
              leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
              header: green_bold
              empty: blue
              # Closures can be used to choose colors for specific values.
              # The value (in this case, a bool) is piped into the closure.
              # eg) {|| if $in { 'light_cyan' } else { 'light_gray' } }
              bool: light_cyan
              int: white
              filesize: cyan
              duration: white
              date: purple
              range: white
              float: white
              string: white
              nothing: white
              binary: white
              cell-path: white
              row_index: green_bold
              record: white
              list: white
              block: white
              hints: dark_gray
              search_result: { bg: red fg: white }
              shape_and: purple_bold
              shape_binary: purple_bold
              shape_block: blue_bold
              shape_bool: light_cyan
              shape_closure: green_bold
              shape_custom: green
              shape_datetime: cyan_bold
              shape_directory: cyan
              shape_external: cyan
              shape_externalarg: green_bold
              shape_external_resolved: light_yellow_bold
              shape_filepath: cyan
              shape_flag: blue_bold
              shape_float: purple_bold
              # shapes are used to change the cli syntax highlighting
              shape_garbage: { fg: white bg: red attr: b}
              shape_glob_interpolation: cyan_bold
              shape_globpattern: cyan_bold
              shape_int: purple_bold
              shape_internalcall: cyan_bold
              shape_keyword: cyan_bold
              shape_list: cyan_bold
              shape_literal: blue
              shape_match_pattern: green
              shape_matching_brackets: { attr: u }
              shape_nothing: light_cyan
              shape_operator: yellow
              shape_or: purple_bold
              shape_pipe: purple_bold
              shape_range: yellow_bold
              shape_record: cyan_bold
              shape_redirection: purple_bold
              shape_signature: green_bold
              shape_string: green
              shape_string_interpolation: cyan_bold
              shape_table: blue_bold
              shape_variable: purple
              shape_vardecl: purple
              shape_raw_string: light_purple
          }

          $env.config = {
            show_banner: false,
            color_config: $dark_theme,
            cursor_shape: {
              emacs: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
              vi_insert: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
              vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
            },
            completions: {
              case_sensitive: false # case-sensitive completions
              quick: true  # set to false to prevent auto-selecting completions
              partial: true  # set to false to prevent partial filling of the prompt
              algorithm: "fuzzy"  # prefix or fuzzy
            },
            table: {
              mode: "rounded"
              index_mode: "always"
              header_on_separator: false
            },
            keybindings: [{
              name: unix-line-discard
              modifier: control
              keycode: char_u
              mode: [emacs, vi_insert, vi_normal]
              event: { until: [{edit: cutfromlinestart}] }
            },
            {
              name: insert-file-using-fzf
              modifier: control
              keycode: char_t
              mode: [emacs, vi_insert, vi_normal]
              event: { send: ExecuteHostCommand, cmd: "commandline edit --insert (fzf)" }
            },
            {
              name: tmux_sessionizer_script
              modifier: control
              keycode: char_f
              mode: [emacs, vi_normal, vi_insert]
              event: { send: ExecuteHostCommand, cmd: "tmux-sessionizer-script"
              }
            },
            ]
          } 
          $env.FZF_DEFAULT_OPTS = [
            "--preview=bat --color=always {}"
            "--multi"
            "--height=100%"
            "--layout=reverse-list"
            "--border=none"
            "--info=inline"
            "--bind=shift-up:preview-page-up,shift-down:preview-page-down"
            "--header=CTRL-c or ESC to quit"
            "--color=bg:-1,bg+:-1"
          ]
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
          gw = "git worktree";
          nb = "nix-build";
          nd = "nix develop";
          ni = "nix-init";
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
        };
      };
    };
  };
}
