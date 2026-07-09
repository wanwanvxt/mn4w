{ pkgs ? import ../../../../../pkgs.nix }:

pkgs.mkShell {
    packages = with pkgs; [
        lua-language-server
        bash-language-server
    ];
}
