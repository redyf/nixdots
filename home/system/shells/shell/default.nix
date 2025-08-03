{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    shell.enable = lib.mkEnableOption "Enable Shell module";
  };
  config = lib.mkIf config.shell.enable {
    home = {
      sessionVariables = {
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
        MANROFFOPT = "-c";
        DIRENV_LOG_FORMAT = ""; # Blank so direnv will shut up
      };
      packages = with pkgs; [
        timer
        (writeShellScriptBin "pomodoro" ''
          # Pomodoro script with colors
          declare -A pomo_options
          pomo_options["work"]="25"
          pomo_options["break"]="5"

          # Color functions
          red() { echo -e "\033[31m$*\033[0m"; }
          green() { echo -e "\033[32m$*\033[0m"; }
          yellow() { echo -e "\033[33m$*\033[0m"; }
          blue() { echo -e "\033[34m$*\033[0m"; }
          magenta() { echo -e "\033[35m$*\033[0m"; }
          cyan() { echo -e "\033[36m$*\033[0m"; }

          pomodoro_single () {
            if [ -n "$1" -a -n "''${pomo_options["$1"]}" ]; then
              val=$1
              if [ "$val" = "work" ]; then
                blue "$val"
              else
                green "$val"
              fi
              timer ''${pomo_options["$val"]}m
              spd-say "$val session done"
            fi
          }

          pomodoro_cycle () {
            cyan "How many work sessions do you want to complete?"
            read -r sessions
            
            if ! [[ "$sessions" =~ ^[0-9]+$ ]] || [ "$sessions" -le 0 ]; then
              red "Please enter a valid positive number."
              return 1
            fi
            
            yellow "Starting $sessions work sessions with breaks..."
            
            for ((i=1; i<=sessions; i++)); do
              magenta "=== Work Session $i of $sessions ==="
              pomodoro_single work
              
              # Don't start a break after the last session
              if [ "$i" -lt "$sessions" ]; then
                cyan "=== Break Time ==="
                pomodoro_single break
              fi
            done
            
            green "All $sessions sessions completed! Great work!"
            spd-say "All sessions completed! Great work!"
          }

          # Handle different usage patterns
          if [ "$1" = "cycle" ]; then
            pomodoro_cycle
          elif [ -n "$1" ]; then
            pomodoro_single "$1"
          else
            cyan "Usage:"
            echo "  pomodoro work     - Single work session"
            echo "  pomodoro break    - Single break session"
            echo "  pomodoro cycle    - Multiple sessions with breaks"
          fi
        '')
      ];
    };
  };
}
