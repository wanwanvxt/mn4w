{ config, pkgs, inputs, ... }:
{
    xdg = {
        enable = true;
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-hyprland
                xdg-desktop-portal-gtk
            ];
            config.common.default = [ "hyprland" "gtk" ];
        };
        userDirs = {
            enable = true;
            createDirectories = true;
            download = "$HOME/downloads";
            music = "$HOME/gallery";
            pictures = "$HOME/gallery";
            videos = "$HOME/gallery";
            desktop = "$HOME/others";
            documents = "$HOME/others";
            publicShare = "$HOME/others";
            templates = "$HOME/others";
        };
    };
}
