{
    description = "My NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        systems.url = "github:nix-systems/default-linux";
        nix-std.url = "github:chessai/nix-std";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs @ {...}: let
        myOverlays = import ./overlays;

        eachSystem = f:
            inputs.nixpkgs.lib.genAttrs (import inputs.systems)
            (system: f inputs.nixpkgs.legacyPackages.${system});

        mkSystem = system: hostname:
            inputs.nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {inherit inputs;};
                modules = [
                    {
                        system.stateVersion = "25.05";
                        nixpkgs.overlays = [
                            inputs.self.overlays.default
                        ];
                        networking.hostName = hostname;
                    }
                    ./modules/hosts/${hostname}
                    inputs.home-manager.nixosModules.home-manager
                ];
            };
    in {
        # `nix fmt`
        formatter = eachSystem (
            pkgs:
                pkgs.treefmt.withConfig {
                    runtimeInputs = with pkgs; [alejandra];
                    settings = pkgs.lib.importTOML ./treefmt.toml;
                }
        );
        # overlays
        overlays =
            myOverlays
            // {
                default = inputs.nixpkgs.lib.composeManyExtensions (builtins.attrValues myOverlays);
            };
        # `nixos-rebuild --flake .#<hostname>`
        nixosConfigurations = {
            laptop = mkSystem "x86_64-linux" "laptop";
        };
    };
}
