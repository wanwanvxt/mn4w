{...}: {
    services = {
        gnome.gnome-keyring.enable = true;
        udisks2.enable = true;
        gvfs.enable = true;
        tumbler.enable = true;
    };

    environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
}
