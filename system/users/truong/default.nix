{...}: {
    users.users.truong = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager" "gamemode" "input"];
    };

    imports = [
        ./locales.nix
        ./gaming.nix
        ./misc.nix
    ];
}
