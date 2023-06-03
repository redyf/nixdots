{
  pkgs,
  lib,
  ...
}: {
  programs.starship = let
    flavour = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
  in {
    enable = true;
    settings =
      {
        add_newline = false;
        scan_timeout = 5;

        character = {
          success_symbol = "[](#cbced3)";
          error_symbol = "[](#dd6777)";
          vicmd_symbol = "[](#ecd3a0)";
          format = "$symbol [✗ ](bold #73daca) ";
          # format = "$symbol [λ ](bold #73daca) ";
        };

        palette = "catppuccin_${flavour}";
        git_commit = {commit_hash_length = 5;};
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
          show_always = true;
          style_user = "bold bg:none fg:blue";
          format = "[$user]($style) ";
        };

        hostname = {
          ssh_only = false;
          style = "bold bg:none fg:#CDD6F4";
          format = "@[$hostname]($style) ";
          disabled = true;
        };

        directory = {
          read_only = " ";
          truncation_length = 3;
          truncation_symbol = "./";
          style = "bold bg:none fg:#7aa2f7";
        };
      }
      // builtins.fromTOML (builtins.readFile (pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "starship";
          rev = "HEAD";
          sha256 = "11pfbly5w5jg44jvgxa8i0h31sqn261l27ahcjibfl5pb9b030dj";
        }
        + /palettes/${flavour}.toml));
  };
}
