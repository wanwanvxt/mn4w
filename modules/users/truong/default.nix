{inputs, ...}: {
    users.users.truong = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager" "gamemode" "input"];
    };

    home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = {inherit inputs;};
        sharedModules = builtins.attrValues (import ../../shared/home);
        users.truong = ./home;
    };
}
