{
  description = "Redyf's NixOS config for desktop and laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    hyprland-nvidia.url = "github:hyprwm/hyprland";
    waybar-hyprland.url = "github:hyprwm/hyprland";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    nur.url = "github:nix-community/NUR";
    nix-colors.url = "github:misterio77/nix-colors";

    # SFMono w/ patches
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    hyprland-nvidia,
    home-manager,
    utils,
    ...
  } @ inputs: {
    nixosConfigurations = {
      redyf =
        nixpkgs.lib.nixosSystem
        {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              inputs
              hyprland-nvidia
              ;
          };
          modules = [
            ./hosts/redyf/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = false;
                extraSpecialArgs = {inherit inputs;};
                users.redyf = ./home/desktop/home.nix;
              };
            }
            hyprland-nvidia.nixosModules.default
            {programs.hyprland.enable = true;}
          ];
        };
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs hyprland-nvidia;
        };
        modules = [
          ./hosts/laptop/configuration.nix
          # home-manager.nixosModules.home-manager
          # {
          #   home-manager = {
          #     useUserPackages = true;
          #     useGlobalPkgs = false;
          #     extraSpecialArgs = {inherit inputs;};
          #     users.redyf = ./home/laptop/laptop.nix;
          #   };
          # }
          hyprland-nvidia.nixosModules.default
          {programs.hyprland.enable = true;}
        ];
      };
    };
    # homeConfigurations = {
    #   "redyf@laptop" = home-manager.lib.homeManagerConfiguration {
    #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #     extraSpecialArgs = {inherit inputs;};
    #     modules = [./home/laptop/laptop.nix];
    #   };
    # };
  };
}
