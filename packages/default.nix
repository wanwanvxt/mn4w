{ pkgs ? import <nixpkgs> {} }:
{
    thaimeleon = pkgs.callPackage ./thaimeleon.nix {};
}
