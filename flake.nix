{
    description = "My NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... } @ inputs:
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
                    modules = [
                        home-manager.nixosModules.home-manager
                        {
                            system.stateVersion = "26.05";
                            nixpkgs.overlays = [ self.overlays.default ];
                            networking.hostName = hostName;
                        }
                        hostConfig
                    ];
                }
            ) hosts;

            overlays.default = import ./overlays;
        in
        { inherit nixosConfigurations overlays; };
}
