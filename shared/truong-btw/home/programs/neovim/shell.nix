{ pkgs ? import ../../../../../pkgs.nix }:

pkgs.mkShell {
    packages = with pkgs; [
        lua-language-server
        vim-language-server
    ];
}
