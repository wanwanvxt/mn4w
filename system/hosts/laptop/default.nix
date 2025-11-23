{ config, pkgs, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ./locales.nix
        ./graphics.nix
        ./gaming.nix
        ./qbittorrent.nix
    ];
}
