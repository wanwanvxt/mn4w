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
        fishline = {
            url = "github:0rax/fishline";
            flake = false;
        };
        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs @ { nixpkgs, home-manager, hyprqt6engine, fishline, quickshell, ... }:
        let
            myOverlays = import ./overlays;
            myHomeModules = import ./home/modules;

            mkSystem = system: hostname: users:
                inputs.nixpkgs.lib.nixosSystem {
                    inherit system;
                    specialArgs = { inherit inputs; };
                    modules = [
                        ./system
                        ./system/hosts/${hostname}
                        {
                            nixpkgs.overlays = [
                                inputs.hyprqt6engine.overlays.default
                                inputs.quickshell.overlays.default
                            ] ++ builtins.attrValues myOverlays;
                            networking.hostName = hostname;
                        }
                        inputs.home-manager.nixosModules.home-manager {
                            home-manager = {
                                useUserPackages = true;
                                useGlobalPkgs = true;
                                extraSpecialArgs = { inherit inputs; };
                                sharedModules = builtins.attrValues myHomeModules;
                                users = builtins.listToAttrs (builtins.map (user: {
                                    name  = user;
                                    value = ./home/users/${user};
                                }) users);
                            };
                        }
                    ] ++ (builtins.map (user: ./system/users/${user}) users);
                };
        in {
            nixosConfigurations = {
                laptop = mkSystem "x86_64-linux" "laptop" ["truong"];
            };
        };
}
