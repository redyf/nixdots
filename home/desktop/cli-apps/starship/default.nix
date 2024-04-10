{pkgs, ...}: {
  home.packages = with pkgs; [starship];
  programs.starship = let
    flavour = "macchiato"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
  in {
    enable = true;
    enableZshIntegration = true;
    settings =
      # Catppuccin
      #     {
      #       scan_timeout = 10;
      #       add_newline = false;
      #       line_break.disabled = false;
      #       right_format = "$time";
      #       character = {
      #         success_symbol = "[](#cbced3)";
      #         error_symbol = "[](#dd6777) ";
      #         vicmd_symbol = "[](#ecd3a0)";
      #         format = "$symbol[ ](bold #b4befe) ";
      #       };
      #
      #       format = ''
      #         $directory$git_branch$git_state$git_metrics$dart$lua$nodejs$package$python$rust$nix_shell$custom
      #         $character
      #       '';
      #
      #       palette = "catppuccin_${flavour}";
      #       git_branch = {
      #         symbol = " ";
      #       };
      #       git_commit = {commit_hash_length = 5;};
      #
      #       dart = {
      #         symbol = "[](blue) ";
      #       };
      #       lua = {
      #         symbol = "[](blue) ";
      #       };
      #       nodejs = {
      #         version_format = "v$raw(blue)";
      #       };
      #       package = {
      #         symbol = "📦";
      #       };
      #       python = {
      #         symbol = "[](blue) ";
      #       };
      #       rust = {
      #         symbol = "[](red) ";
      #       };
      #       shell = {
      #         disabled = true;
      #         zsh_indicator = "zsh";
      #       };
      #
      #       username = {
      #         show_always = false;
      #         style_user = "bold bg:none fg:#7aa2f7";
      #         format = "[$user]($style)";
      #       };
      #
      #       hostname = {
      #         disabled = true;
      #         ssh_only = false;
      #         style = "bold bg:none fg:#CDD6F4";
      #         format = "@[$hostname]($style) ";
      #       };
      #
      #       directory = {
      #         read_only = " ";
      #         truncation_length = 3;
      #         truncation_symbol = "./";
      #         # style = "bold bg:none fg:#393939";
      #         # style = "bold bg:none fg:#7aa2f7";
      #         style = "bold bg:none fg:#b4befe";
      #         # style = "bold bg:none fg:#7dcfff";
      #         # style = "bold bg:none fg:#ec6a88";
      #       };
      #
      #       time = {
      #         disabled = true;
      #         use_12hr = true;
      #         time_range = "-";
      #         time_format = "%R";
      #         utc_time_offset = "local";
      #         format = "[ $time 󰥔]($style) ";
      #         style = "bold #393939";
      #       };
      #
      #       nix_shell = {
      #         disabled = false;
      #         heuristic = false;
      #         impure_msg = "[impure-shell](red)";
      #         pure_msg = "[pure-shell](green)";
      #         unknown_msg = "[unknown-shell](yellow)";
      #       };
      #
      #       custom = {
      #         nix = {
      #           disabled = false;
      #           detect_files = ["flake.nix" "default.nix" "shell.nix"];
      #           # format = "via [$symbol nix-shell]($style) ";
      #           command = ''
      #             if [ -e flake.nix ] || [ -e default.nix ] || [ -e shell.nix ]; then
      #               echo " (nix-shell)"
      #             fi
      #           '';
      #           format = "[$symbol$output]($style)";
      #           style = "bold blue";
      #           symbol = "[](bold blue) ";
      #         };
      #       };
      #     }
      #     // builtins.fromTOML (builtins.readFile (pkgs.fetchFromGitHub
      #       {
      #         owner = "catppuccin";
      #         repo = "starship";
      #         rev = "HEAD";
      #         sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
      #       }
      #       + /palettes/${flavour}.toml));
      # };
      # Mocha
      #   {
      #     add_newline = false;
      #     format = ''
      #       [](#b4befe)[  ](bg:#b4befe fg:black)[](bg:black fg:#b4befe)$directory[](black) $git_branch$nix_shell
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
      #       success_symbol = "[🠚 ](bold #b4befe)";
      #       error_symbol = "[🠚 ](bold #dd6777)";
      #     };
      #     nix_shell = {
      #       symbol = "[](bold #7aa2f7) ";
      #   };
      # };
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

        nix_shell = {
          disabled = false;
          heuristic = false;
          impure_msg = "[impure-shell](red)";
          pure_msg = "[pure-shell](green)";
          unknown_msg = "[unknown-shell](yellow)";
        };
      };
  };
}
