{
    description = "My NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        systems.url = "github:nix-systems/default-linux";
        treefmt-nix = {
            url = "github:numtide/treefmt-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs @ {...}: let
        myOverlays = import ./overlays;
        myHomeModules = import ./home/modules;

        eachSystem = f: inputs.nixpkgs.lib.genAttrs (import inputs.systems) (system: f inputs.nixpkgs.legacyPackages.${system});

        treefmtEval = eachSystem (pkgs:
            inputs.treefmt-nix.lib.evalModule pkgs {
                projectRootFile = "flake.nix";
                settings.global.excludes = ["*/hardware-configuration.nix"];

                programs.alejandra.enable = true;
            });

        mkSystem = system: hostname: users:
            inputs.nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {inherit inputs;};
                modules =
                    [
                        ./system
                        ./system/hosts/${hostname}
                        {
                            nixpkgs.overlays = [
                                inputs.self.overlays.default
                            ];
                            networking.hostName = hostname;
                        }
                        ###################################################################
                        inputs.home-manager.nixosModules.home-manager
                        {
                            home-manager = {
                                useUserPackages = true;
                                useGlobalPkgs = true;
                                extraSpecialArgs = {inherit inputs;};
                                sharedModules = builtins.attrValues myHomeModules;
                                users = builtins.listToAttrs (builtins.map (user: {
                                    name = user;
                                    value = ./home/users/${user};
                                })
                                users);
                            };
                        }
                    ]
                    ++ (builtins.map (user: ./system/users/${user}) users);
            };
    in {
        # `nix fmt`
        formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
        # overlays
        overlays =
            myOverlays
            // {
                default = inputs.nixpkgs.lib.composeManyExtensions (builtins.attrValues myOverlays);
            };
        # `nixos-rebuild --flake ./#<hostname>`
        nixosConfigurations = {
            laptop = mkSystem "x86_64-linux" "laptop" ["truong"];
        };
    };
}
