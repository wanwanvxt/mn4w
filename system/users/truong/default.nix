{ config, pkgs, inputs, ... }:
{
    users.users.truong = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "gamemode" "input" ];
    };

    imports = [
        ./gaming.nix
        ./locales.nix
    ];
}
