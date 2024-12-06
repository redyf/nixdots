{ pkgs }:
let
  flavour = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
in
{
  command_timeout = 1000;
  "$schema" = "https://starship.rs/config-schema.json";
  add_newline = false;
  right_format = ''$all'';
  format = ''
    $directory$custom$git_branch$git_state$git_status$line_break$character
  '';

  palette = "catppuccin_${flavour}";

  os = {
    disabled = true;
    #style = "bg:surface0 fg:text"
    symbols = {
      Windows = "󰍲";
      Ubuntu = "󰕈";
      SUSE = "";
      Raspbian = "󰐿";
      Mint = "󰣭";
      Macos = " ";
      Manjaro = "";
      Linux = "󰌽";
      Gentoo = "󰣨";
      Fedora = "󰣛";
      Alpine = "";
      Amazon = "";
      Android = "";
      Arch = "󰣇";
      Artix = "󰣇";
      CentOS = "";
      Debian = "󰣚";
      Redhat = "󱄛";
      RedHatEnterprise = "󱄛";
    };
  };

  username = {
    #show_always = true
    #style_user = "bg:surface0 fg:text"
    #style_root = "bg:surface0 fg:text"
    #format = '[ $user ]($style)'
  };

  directory = {
    format = "[ $path ]($style)";
    #truncation_length = 4
    #truncation_symbol = "…/"
    substitutions = {
      "Documents" = "󰈙 ";
      "Downloads" = " ";
      "Music" = "󰝚 ";
      "Pictures" = " ";
      "Developer" = "󰲋 ";
    };
  };

  custom = {
    giturl = {
      # disabled = true
      description = "Display symbol for remote Git server";
      command = ''
        GIT_REMOTE=$(command git ls-remote --get-url 2> /dev/null)
        if [[ "$GIT_REMOTE" =~ "github" ]]; then
            GIT_REMOTE_SYMBOL=" "
        elif [[ "$GIT_REMOTE" =~ "gitlab" ]]; then
            GIT_REMOTE_SYMBOL=" "
        elif [[ "$GIT_REMOTE" =~ "bitbucket" ]]; then
            GIT_REMOTE_SYMBOL=" "
        elif [[ "$GIT_REMOTE" =~ "git" ]]; then
            GIT_REMOTE_SYMBOL=" "
        else
            GIT_REMOTE_SYMBOL=" "
        fi
        echo "$GIT_REMOTE_SYMBOL "
      '';
      when = "git rev-parse --is-inside-work-tree 2> /dev/null";
      format = "at $output";
    };
  };

  git_branch = {

    symbol = "[](black) ";
    # format =  " [$symbol$branch(:$remote_branch)]($style)[]";
    style = "fg:lavender bg:black";
    format = "  on [$symbol$branch]($style)[](black)";
  };

  git_status = {
    format = " [($all_status$ahead_behind )]($style)";
  };

  nodejs = {
    symbol = "";
    format = "[ $symbol( $version) ]($style)";
  };

  c = {
    symbol = " ";
    format = "[ $symbol( $version) ]($style)";
  };

  rust = {
    symbol = "";
    format = "[ $symbol( $version) ]($style)";
  };

  golang = {
    symbol = "";
    format = "[ $symbol( $version) ]($style)";
    detect_files = [ "go.mod" ];
  };

  php = {
    symbol = "";
    format = "[ $symbol( $version) ]($style)";
  };

  java = {
    symbol = " ";
    format = "[ $symbol( $version) ]($style)";
  };

  kotlin = {
    symbol = "";
    format = "[ $symbol( $version) ]($style)";
  };

  haskell = {
    symbol = "";
    format = "[ $symbol( $version) ]($style)";
  };

  python = {
    symbol = "";
    format = "[ $symbol( $version) ]($style)";
  };

  docker_context = {
    symbol = "";
    format = "[ $symbol( $context) ]($style)";
  };

  time = {
    disabled = true;
    time_format = "%R";
    style = "bg:peach";
    format = "[[  $time ](fg:mantle bg:foam)]($style)";
  };

  line_break = {
    disabled = true;
  };

  character = {
    disabled = false;
    success_symbol = "[✘ ](bold fg:green)";
    error_symbol = "[✘ ](bold fg:red)";
    vimcmd_symbol = "[](bold fg:creen)";
    vimcmd_replace_one_symbol = "[](bold fg:purple)";
    vimcmd_replace_symbol = "[](bold fg:purple)";
    vimcmd_visual_symbol = "[](bold fg:lavender)";
  };
}
// builtins.fromTOML (
  builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "HEAD";
      sha256 = "sha256-TjcoBlgmRoqXKdXH/eC5dWk7uqUSkvyV4ir9WqFR1pY=";
    }
    + /themes/${flavour}.toml
  )
)
