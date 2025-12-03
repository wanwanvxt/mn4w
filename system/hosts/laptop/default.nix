{ config, pkgs, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ./graphics.nix
    ];
}
