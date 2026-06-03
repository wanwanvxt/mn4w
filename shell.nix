{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    packages = with pkgs; [
        nixd
        bash-language-server

        # neovim
        lua-language-server
        vim-language-server
    ];
}
