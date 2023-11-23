{
  pkgs,
  lib,
  ...
}: {
  # Catppuccin
  programs.starship = let
    flavour = "macchiato"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
  in {
    enable = true;
    enableZshIntegration = true;
    settings =
      # Catppuccin
      # {
      #   scan_timeout = 10;
      #   add_newline = false;
      #   line_break.disabled = false;
      #   right_format = "$time";
      #   character = {
      #     success_symbol = "[](#cbced3)";
      #     error_symbol = "[](#dd6777)";
      #     vicmd_symbol = "[](#ecd3a0)";
      #     format = "$symbol[λ ](bold #3fdaa4) ";
      #     # format = "$symbol[✘ ](bold #3fdaa4) ";
      #   };
        # Oxocarbon
        {
          scan_timeout = 10;
          add_newline = true;
          line_break.disabled = false;
          format = "$symbol[󰉊 ](bold #ee5396) $directory$character";
          right_format = "$time";
          character = {
            success_symbol = "[󰅂 ](bold #393939)";
            error_symbol = "[󰅂 ](bold #393939)";
            vicmd_symbol = "[󰅂 ](bold #393939)";
          };

        palette = "catppuccin_${flavour}";
        git_commit = {commit_hash_length = 5;};

        lua.symbol = "[](blue) ";
        python.symbol = "[](blue) ";
        nix_shell.symbol = "[](blue) ";
        rust.symbol = "[](red) ";
        dart.symbol = "[](blue) ";
        # nodejs.symbol = "[󰎙](#3fdaa4) ";
        # nodejs.symbol = "[󰎙](#7aa2f7) ";
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
          style = "bold bg:none fg:#393939";
          # style = "bold bg:none fg:#7aa2f7";
          # style = "bold bg:none fg:#7dcfff";
          # style = "bold bg:none fg:#26bbd9";
          # style = "bold bg:none fg:#7EAE90";
          # style = "bold bg:none fg:#ec6a88";
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

  # Decay
  # programs.starship = {
  #   enable = true;
  #   settings = {
  #     add_newline = false;
  #     format = ''
  #       [](#7aa2f7)[  ](bg:#7aa2f7 fg:black)[](bg:black fg:#7aa2f7)$directory[](black) $git_branch$nix_shell
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
  #       success_symbol = "[🠚 ](bold #7aa2f7)";
  #       error_symbol = "[🠚 ](bold #dd6777)";
  #     };
  #     nix_shell = {
  #       symbol = "[](bold #7aa2f7) ";
  #     };
  #   };
  # };
}
