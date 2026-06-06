{ pkgs, config, lib, ... }:
let
    graphicsCfg = config.hardware.graphics;
    nvidiaCfg = config.hardware.nvidia;
in
{
    environment = {
        systemPackages = with pkgs; [
            tree
            less
            fzf
            ripgrep
            neovim

            git
            curl
            wget

            htop
            (lib.mkIf graphicsCfg.enable (nvtopPackages.full.override {
                intel = true;
                amd = true;
                nvidia = nvidiaCfg.enabled;
            }))
            gdu
        ];

        variables = {
            EDITOR = "nvim";
            VISUAL = "nvim";
            PAGER = "less";
            MANPAGER = "nvim +Man!";
        };

        pathsToLink = [
            "/share/applications"
            "/share/xdg-desktop-portal"
            "/share/color-schemes"
            "/share/fish"
        ];
    };

    programs = {
        less.enable = lib.mkForce false;
        nano.enable = false;
        dconf.enable = true;
        uwsm.enable = true;
    };

    services.gnome.gnome-keyring.enable = true;
}
