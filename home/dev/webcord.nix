{ inputs
, config
, pkgs
, ...
}: {
  imports = [
    inputs.webcord.homeManagerModules.default
  ];
  programs.webcord = {
    enable = true;
    package = inputs.webcord.packages.${pkgs.system}.default;
    themes =
      let
        catppuccin = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "discord";
          rev = "be898e83d7bbf6eed94e3edca09cd68786e06c2a";
          sha256 = "1a2czbhcwagygihhscrzqy4argsqrcdcjjgdrscp3ip5619k9mxn";
        };
      in
      {
        CatpuccinMocha = "${catppuccin}/themes/mocha.theme.css";
      };
  };
}
