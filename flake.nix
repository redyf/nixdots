{
  description = "Redyf's Flake";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    waybar-hyprland.url = "github:hyprwm/hyprland";
    nur.url = "github:nix-community/NUR";
    Neve.url = "github:redyf/Neve";
    disko.url = "github:nix-community/disko";
    stylix.url = "github:danth/stylix";
    ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";

    # git+ssh://git@git.example.com/User/repo.git
    # fontflake.url = "git+ssh://git@github.com/redyf/font-flake.git";

    # liga-martian-mono = {
    #   url = "github:redyf/LigaMartianMono";
    #   flake = false;
    # };

    # SFMono w/ patches
    # sf-mono-liga-src = {
    #   url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
    #   flake = false;
    # };

    # berkeley = {
    #   url = "git+ssh://git@github.com/redyf/berkeley.git";
    #   flake = false;
    # };

    # monolisa-script = {
    #   url = "git+ssh://git@github.com/redyf/test2.git";
    #   flake = false;
    # };
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    home-manager,
    disko,
    stylix,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];

    # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # Nixpkgs instantiated for supported system types.
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    nixosConfigurations = {
      redyf =
        nixpkgs.lib.nixosSystem
        {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              inputs
              hyprland
              disko
              ;
          };
          modules = [
            ./hosts/redyf/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = false;
                extraSpecialArgs = {inherit inputs disko;};
                users.redyf = ./home/redyf/home.nix;
                backupFileExtension = "backup";
              };
            }
            stylix.nixosModules.stylix
            hyprland.nixosModules.default
            disko.nixosModules.disko
          ];
        };
      # selene = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = {
      #     inherit
      #       inputs
      #       hyprland
      #       disko
      #       ;
      #   };
      #   modules = [
      #     ./hosts/selene/configuration.nix
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager = {
      #         useUserPackages = true;
      #         useGlobalPkgs = false;
      #         extraSpecialArgs = {inherit inputs disko;};
      #         users.selene = ./home/selene/home.nix;
      #       };
      #     }
      #     hyprland.nixosModules.default
      #     {programs.hyprland.enable = false;}
      #     disko.nixosModules.disko
      #   ];
      # };
    };
    devShells = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git
          alejandra
          statix
        ];
      };
    });
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
