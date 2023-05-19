_: {
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      scan_timeout = 5;

      character = {
        success_symbol = "[](#cbced3)";
        error_symbol = "[](#dd6777)";
        vicmd_symbol = "[](#ecd3a0)";
        format = "$symbol [λ ](bold #73daca ) ";
      };

      git_commit = { commit_hash_length = 5; };
      line_break.disabled = false;

      lua.symbol = "[](blue) ";
      python.symbol = "[](blue) ";
      nix_shell.symbol = "[](blue) ";
      rust.symbol = "[](red) ";
      dart.symbol = "[](blue) ";
      package.symbol = "📦  ";

      # TODO: add git options and change color to #7aa2f7
      # TODO: add new icons to languages

      username = {
        show_always = false;
        style_user = "bold bg:#1E1E2E fg:blue";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        format = "@[$hostname](bold #CDD6F4) ";
        disabled = true;
      };

      directory = {
        read_only = " ";
        truncation_length = 3;
        truncation_symbol = "./";
        style = "bold bg:none fg:#7aa2f7";
      };
    };
  };
}
