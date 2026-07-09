{ pkgs ? import ./pkgs.nix }:

pkgs.mkShell {
    packages = with pkgs; [
        nixd
        bash-language-server
    ];
}
