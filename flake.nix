{
  description = "Redyf's Snowfall Lib config";

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    manix = {
      url = "github:nix-community/manix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    waybar-hyprland.url = "github:hyprwm/hyprland";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    nur.url = "github:nix-community/NUR";
    nix-colors.url = "github:misterio77/nix-colors";
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    Neve.url = "github:redyf/Neve";
    disko.url = "github:nix-community/disko";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # SFMono w/ patches
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
  };

  outputs = inputs:
    let
      inherit (inputs) hyprland nixpkgs;
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          meta = {
            name = "nixdots";
            title = "nixdots";
          };

          namespace = "custom";
        };
      };
    in
    lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
        allowUnfreePredicate = pkg: true;
        packageOverrides = pkgs: {
          # integrates nur within Home-Manager
          nur =
            import
              (builtins.fetchTarball {
                url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
                sha256 = "sha256:1gr3l5fcjsd7j9g6k9jamby684k356a36h82cwck2vcxf8yw8xa0";
              })
              { inherit pkgs; };
        };
      };

      # You can also pass through external packages or dynamically create new ones
      # in addition to the ones that `lib` will create from your `packages/` directory.
      # outputs-builder = channels: {
      #   packages = {
      #     spicetify-nix = spicetify-nix.packages.${channels.nixpkgs.system}.default;
      #   };
      # };

      overlays = with inputs; [
        inputs.neovim-nightly-overlay.overlay
        (
          final: prev: {
            sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
              pname = "sf-mono-liga-bin";
              version = "dev";
              src = inputs.sf-mono-liga-src;
              dontConfigure = true;
              installPhase = ''
                mkdir -p $out/share/fonts/opentype
                cp -R $src/*.otf $out/share/fonts/opentype/
              '';
            };
          }
        )
      ];

      # Add modules to all NixOS systems.
      systems.modules.nixos = with inputs; [
        spicetify-nix.nixosModule
        disko.nixosModules.disko
      ];

      # Add a module to a specific host.
      systems = {
        hosts = {
          # redyf = {
          #   modules = with inputs; [
          #     (import ./disks/default.nix {
          #       inherit lib;
          #       device = "/dev/nvme0n1";
          #     })
          #   ];
          # };
          wsl = {
            modules = with inputs; [
              nixos-wsl.nixosModules.wsl
            ];
          };
          testing = {
            modules = with inputs; [
              (import ./disks/default.nix {
                inherit lib;
                device = "/dev/vda";
              })
            ];
          };
          vm = {
            modules = with inputs; [
              (import ./disks/default.nix {
                inherit lib;
                device = "/dev/vda";
              })
            ];
          };
        };
      };

      # Add modules to all homes.
      # homes.modules = with inputs; [
      # ];

      # deploy = lib.mkDeploy {
      #   inherit (inputs) self;
      # };
      #
      # checks =
      #   builtins.mapAttrs
      #     (_system: deploy-lib:
      #       deploy-lib.deployChecks inputs.self.deploy)
      #     inputs.deploy-rs.lib;

      templates = import ./templates { };


      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              git
              nixpkgs-fmt
              statix
            ];
          };
        });
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
