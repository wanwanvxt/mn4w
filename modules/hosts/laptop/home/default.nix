{
    home-manager.users.truong = {
        imports = [
            ../../../shared/truong/home
            ./niri.nix
        ];
    };
}
