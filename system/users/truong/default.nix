{ config, pkgs, inputs, ... }:
{
    users.users.truong = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "gamemode" "input" ];
    };

    import = [
        ./gaming.nix
        ./locales.nix
    ];
}
