{
  scan_timeout = 10;
  add_newline = false;
  line_break.disabled = false;
  format = ''
    $symbol[λ ](bold #ee5396)$username$git_branch
    $directory$character
  '';
  # format = "$symbol[󰉊 ](bold #ee5396) $directory$character
  right_format = "$cmd_duration$time";
  character = {
    success_symbol = "[󰅂 ](bold #393939)";
    error_symbol = "[󰅂 ](bold #393939)";
    vicmd_symbol = "[󰅂 ](bold #393939)";
  };

  username = {
    show_always = true;
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
    style = "bold bg:none fg:#393939";
  };

  git_branch = {
    format = " on [$symbol$branch(:$remote_branch)]($style) ";
    symbol = " ";
    style = "bold #be95ff";
  };

  time = {
    disabled = false;
    use_12hr = true;
    time_range = "-";
    time_format = "%R";
    utc_time_offset = "local";
    format = "[ $time 󰥔]($style) ";
    style = "bold #393939";
  };

  nix_shell = {
    disabled = false;
    heuristic = false;
    impure_msg = "[impure-shell](red)";
    pure_msg = "[pure-shell](green)";
    unknown_msg = "[unknown-shell](yellow)";
  };

  cmd_duration = {
    min_time = 2000;
    show_milliseconds = false;
    format = "took [$duration]($style)";
    style = "bold yellow";
    disabled = false;
  };
}
