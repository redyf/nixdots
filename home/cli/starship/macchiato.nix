{ pkgs }:
let
  flavour = "macchiato"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
in
{
  scan_timeout = 30;
  command_timeout = 2000;
  add_newline = false;
  line_break.disabled = false;
  right_format = ''
    $all
  '';
  character = {
    success_symbol = "[](#cbced3)";
    error_symbol = "[](#dd6777) ";
    vicmd_symbol = "[](#ecd3a0)";
    # format = "$symbol[ ](bold #b4befe) ";
    # format = "$symbol[λ ](bold #b4befe) ";
    # format = "$symbol[󰅂](#b4befe) ";
    format = "$symbol[;](#b4befe) ";
  };

  format = ''
    $directory$git_branch$git_state$git_metrics$dart$lua$nodejs$package$python$rust$nix_shell$custom
    $character
  '';

  # format = ''
  #   $username$git_branch$git_state$git_status$git_commit$git_metrics$nix_shell$aws
  #   $directory$character
  # '';

  palette = "catppuccin_${flavour}";

  aws = {
    format = "on [$symbol($profile )(\($region) )]($style)";
    style = "bold blue";
    symbol = " ";
  };

  dart = {
    format = "via [$symbol($version )]($style)";
    symbol = "[]($style) ";
    style = "bold blue";
  };

  direnv = {
    format = "[$symbol$loaded/$allowed]($style) ";
    symbol = "direnv ";
    style = "bold orange";
    disabled = true;
  };

  docker_context = {
    disabled = true;
  };

  elixir = {
    format = "via [$symbol($version \(OTP $otp_version\) )]($style)";
    symbol = " ";
    style = "bold purple";
  };

  git_branch = {
    format = "on [$symbol$branch(:$remote_branch)]($style) ";
    symbol = " ";
    style = "bold purple";
  };

  git_commit = {
    format = "[\($hash$tag\)]($style) ";
    commit_hash_length = 7;
    style = "bold green";
  };

  golang = {
    format = "via [$symbol($version )]($style)";
    style = "bold blue";
    symbol = "[ ]($style)";
  };

  haskell = {
    format = "via [$symbol($version )]($style)";
    symbol = "λ ";
    style = "bold purple";
  };

  kubernetes = {
    symbol = "☸ ";
    disabled = false;
    detect_files = [ "Dockerfile" ];
    format = "[$context(\[$namespace\])]($style) ";
  };

  lua = {
    format = "via [$symbol($version )]($style)";
    symbol = "[]($style) ";
    style = "bold blue";
  };

  nix_shell = {
    symbol = " ";
    format = "via [$symbol$state]($style) ";
    # symbol = "󱄅 ";
    # format = "via [$symbol$state( \($name\))]($style) ";
    style = "bold blue";
    disabled = false;
  };

  nodejs = {
    format = "via [$symbol($version )]($style)";
    style = "bold green";
    symbol = " ";
    version_format = "v$raw(blue)";
  };

  ocaml = {
    format = "via [$symbol($version )(\($switch_indicator$switch_name\) )]($style)";
    symbol = "🐫 ";
    style = "bold yellow";
    version_format = "v$raw";
  };

  package = {
    format = "is [$symbol$version]($style) ";
    symbol = " ";
    style = "bold 208";
  };

  python = {
    format = "via [$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)";
    symbol = "[]($style) ";
    style = "bold blue";
  };

  rust = {
    format = "via [$symbol($version )]($style)";
    symbol = "[]($style) ";
    style = "bold #f74b00";
  };

  shell = {
    disabled = true;
    zsh_indicator = "zsh";
  };

  custom = {
    nix = {
      disabled = true;
      detect_files = [
        "flake.nix"
        "default.nix"
        "shell.nix"
      ];
      # format = "via [$symbol nix-shell]($style) ";
      # command = ''
      #   if [ -e flake.nix ] || [ -e default.nix ] || [ -e shell.nix ]; then
      #     echo " (nix-shell)"
      #   fi
      # '';
      format = "[$symbol$output]($style)";
      style = "bold blue";
      symbol = "[](bold blue) ";
    };
  };

  username = {
    show_always = true;
    # style_user = "bold bg:none fg:#7aa2f7";
    # format = "[$user]($style)";
    format = "[ $user]($style) ";
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
    # style = "bold bg:none fg:#7aa2f7";
    style = "bold bg:none fg:#b4befe";
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
// builtins.fromTOML (
  builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "starship";
      rev = "HEAD";
      sha256 = "sha256-1w0TJdQP5lb9jCrCmhPlSexf0PkAlcz8GBDEsRjPRns=";
    }
    + /themes/${flavour}.toml
  )
)
