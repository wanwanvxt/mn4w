{ pkgs, config, lib, ... }:
let
    xdgCfg = config.xdg;
in
{
    config = lib.mkIf config.truong-btw.enable {
        home.packages = with pkgs; [
            (lib.mkIf xdgCfg.enable xdg-utils)
            trash-cli
            jq
        ];
    };

    imports = [
        ./bash.nix
        ./git.nix
        ./ssh.nix
        ./neovim
    ];
}
