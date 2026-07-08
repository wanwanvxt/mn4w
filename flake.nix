{
    description = "My NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-std.url = "github:chessai/nix-std";
    };

    outputs = { self, nixpkgs, home-manager, nix-std, ... } @ inputs:
        let
            getChildDirs = path:
                let content = builtins.readDir path;
                in builtins.attrNames (nixpkgs.lib.filterAttrs (name: type: type == "directory") content);
            hostNames = getChildDirs ./hosts;
            hosts = builtins.listToAttrs (map (name: {
                inherit name;
                value = import ./hosts/${name};
            }) hostNames);

            nixosConfigurations = builtins.mapAttrs (hostName: hostConfig:
                nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit nix-std; };
                    modules = [
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.extraSpecialArgs = { inherit nix-std; };
                            system.stateVersion = "26.05";
                            nixpkgs.overlays = [ self.overlays.default ];
                            networking.hostName = hostName;
                        }
                        hostConfig
                    ];
                }
            ) hosts;

            overlays.default = import ./overlays;

            forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
            packages = forAllSystems (system:
                let pkgs = import nixpkgs { inherit system; };
                in import ./packages { inherit pkgs; }
            );
        in
        { inherit nixosConfigurations overlays packages; };
}
