{
    description = "My NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
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

    outputs = inputs @ { nixpkgs, home-manager, fishline, quickshell, ... }:
        let
            mkSystem = system: hostname: users:
            inputs.nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs; };
                modules = [
                    {
                        nixpkgs.overlays = import ./overlays;
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
