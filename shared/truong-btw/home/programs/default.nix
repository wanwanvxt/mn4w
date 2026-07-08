{ pkgs, config, lib, ... }:
let
    xdgCfg = config.xdg;
in
{
    config = lib.mkIf config.truong-btw.enable {
        home.packages = with pkgs; [
            (lib.mkIf xdgCfg.enable xdg-utils)
            wl-clipboard
            trash-cli
            jq
        ];

        services.playerctld.enable = true;
    };

    imports = [
        ./bash.nix
        ./git.nix
        ./ssh.nix
        ./neovim
    ];
}
