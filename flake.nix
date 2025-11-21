{
    description = "My NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprqt6engine = {
            url = "github:hyprwm/hyprqt6engine";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs @ { nixpkgs, home-manager, hyprqt6engine, ... }:
        let
            mkSystem = system: hostname: users:
            inputs.nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs; };
                modules = [
                    {
                        nixpkgs.overlays = [
                            inputs.hyprqt6engine.overlays.default
                            (final: prev: {
                                hyprqt6engine = prev.hyprqt6engine.overrideAttrs (oldAttrs: {
                                    buildInputs = (oldAttrs.buildInputs or []) ++ [
                                        prev.kdePackages.kconfig
                                        prev.kdePackages.kcolorscheme
                                        prev.kdePackages.kiconthemes
                                    ];

                                    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [
                                        prev.kdePackages.extra-cmake-modules
                                    ];
                                });
                            })
                        ];
                    }
                    ./system
                    ./system/hosts/${hostname}
                    { networking.hostName = hostname; }
                    inputs.home-manager.nixosModules.home-manager {
                        home-manager = {
                            useUserPackages = true;
                            useGlobalPkgs = true;
                            extraSpecialArgs = { inherit inputs; };
                            users = builtins.listToAttrs (builtins.map (user: {
                                name  = user;
                                value = ./home/${user};
                            }) users);
                        };
                    }
                ] ++ (builtins.map (user: ./system/users/${user}.nix) users);
            };
        in {
            nixosConfigurations = {
                laptop = mkSystem "x86_64-linux" "laptop" ["truong"];
            };
        };
}
