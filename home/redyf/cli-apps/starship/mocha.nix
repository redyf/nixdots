{
  add_newline = false;
  format = ''
    [](#b4befe)[  ](bg:#b4befe fg:black)[](bg:black fg:#b4befe)$directory[](black) $git_branch$nix_shell
    $character
  '';
  directory = {
    format = "[ $path ]($style)";
    style = "bg:black";
    truncate_to_repo = false;
  };
  git_branch = {
    style = "bold yellow";
  };
  character = {
    success_symbol = "[🠚 ](bold #b4befe)";
    error_symbol = "[🠚 ](bold #dd6777)";
  };
  nix_shell = {
    symbol = "[](bold #7aa2f7) ";
  };
}
