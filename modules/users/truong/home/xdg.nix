{pkgs, ...}: {
    xdg = {
        enable = true;
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-hyprland
                xdg-desktop-portal-gtk
                kdePackages.xdg-desktop-portal-kde
            ];
            config.common = {
                default = ["hyprland" "gtk"];
                "org.freedesktop.impl.portal.FileChooser" = "kde";
            };
        };
        userDirs = {
            enable = true;
            createDirectories = true;
            download = "$HOME/downloads";
            music = "$HOME/media";
            pictures = "$HOME/media";
            videos = "$HOME/media";
            desktop = "$HOME/others";
            documents = "$HOME/others";
            publicShare = "$HOME/others";
            templates = "$HOME/others";
        };
    };

    home.packages = with pkgs; [
        xdg-utils
    ];
}
