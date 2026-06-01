{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    packages = with pkgs; [
        nixd
        bash-language-server
        lua-language-server
        vim-language-server
    ];
}
