{
  description = "Redyf's NixOS config for desktop, laptop and WSL";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/hyprland";
    waybar-hyprland.url = "github:hyprwm/hyprland";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    nur.url = "github:nix-community/NUR";
    nix-colors.url = "github:misterio77/nix-colors";
    spicetify-nix.url = "github:the-argus/spicetify-nix";

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
    hyprland,
    home-manager,
    NixOS-WSL,
    spicetify-nix,
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
              hyprland
              spicetify-nix
              ;
          };
          modules = [
            ./hosts/redyf/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = false;
                extraSpecialArgs = {inherit inputs spicetify-nix;};
                users.redyf = ./home/desktop/home.nix;
              };
            }
            hyprland.nixosModules.default
            {programs.hyprland.enable = true;}
          ];
        };
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs hyprland;
        };
        modules = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = false;
              extraSpecialArgs = {inherit inputs;};
              users.redyf = ./home/laptop/laptop.nix;
            };
          }
          hyprland.nixosModules.default
          {programs.hyprland.enable = true;}
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {nix.registry.nixpkgs.flake = nixpkgs;}
          ./hosts/wsl/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = false;
              users.red = ./home/wsl/home.nix;
            };
          }
          NixOS-WSL.nixosModules.wsl
        ];
      };
    };
  };
}
