{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    packages = with pkgs; [
        lua-language-server
        vim-language-server
    ];
}
