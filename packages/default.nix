{ pkgs ? import ../pkgs.nix }:
{
    thaimeleon = pkgs.callPackage ./thaimeleon.nix {};
    xdg-sound = pkgs.callPackage ./xdg-sound.nix {};
}
