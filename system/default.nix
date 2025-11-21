{ config, pkgs, inputs, ... }:
{
    system.stateVersion = "25.05";

    imports = [
        ./boot.nix
        ./nix.nix
        ./locales.nix
        ./networking.nix
        ./audio.nix
        ./bluetooth.nix
        ./graphics.nix
        ./misc.nix
    ];
}
